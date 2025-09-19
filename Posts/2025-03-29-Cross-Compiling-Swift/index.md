---
title: Cross Compiling Swift
tags: [Swift, Linux]
excerpt: There are multiple ways to cross-compile Swift on different platforms. I explored a few methods while building a Discord bot and a Bluesky bot.
created_at: 2025-03-29
---

I recently did a few small projects in Swift, and I wanted to run each of them on my home server running Gentoo Linux. I decided to do each of them in Swift, not because I thought it'd be easiest, but because I was curious about the challenge of compiling Swift from my Mac to my Linux machine. I'd heard lots recently about new [static Linux Swift SDKs](https://www.swift.org/documentation/articles/static-linux-getting-started.html) (and the Swift SDK API being introduced), and have always had an interest in [Vapor](https://vapor.codes/)

## Link Embed Bot

The first project was a small link embedding bot for Discord. Some websites don't support Discord's embed UI when sending their links. One such website is Instagram. My friends often send memes and such from Instagram, and we'd used the [ddinstagram](https://github.com/Wikidepia/InstaFix) URL previously to embed those videos in Discord messages, but that URL has become flaky and often just refuses to embed anything (it's a volunteer-run service and I don't want to bash on it, it works about 70% of the time).

So my goal was to create a Discord bot that would run 24/7 with an open WebSocket connection. That could get a little more expensive than I was willing to pay if run on a cloud provider (I was hoping to pay nothing). The bot would download images too, so it needed some memory. Thankfully, my home server meets those requirements perfectly. It's on all the time and has 8GB of RAM.

I used the [DiscordBM](https://github.com/DiscordBM/DiscordBM) package (the same one that powers Vapor's Penny bot!) to implement it, and I won't go into the details of reverse engineering Instagram's API to download images, reels, and videos from their server and upload them to Discord, but it is really cool if I do say so myself.

<video controls width="90%" style="margin-bottom: 1.5em;">
    <source src="linkembedbot.mp4" type="video/mp4">
  	Your browser does not support the video tag.
</video>

Anyways, what I ended up with was a working Swift executable package. When executed, it started the connection with Discord and began processing events. The issue was, I wanted to run this on my [Gentoo](https://www.gentoo.org/) machine, but I had developed it on my Mac. In comes the power of static Linux Swift SDKs!

## Method 1: Static Linux Swift SDK

Swift introduced static Linux Swift SDKs a while ago to help meet the need to compile Swift programs for a platform other than the one it's being compiled on. A Swift SDK contains the information Swift needs to know to create a *statically linked executable*. This executable contains the Swift runtime, standard libraries, even libraries the standard library depends on. This executable will run on any Linux machine once compiled, with no dependencies.

The downside of this method is that we cannot make use of the fact that most distros ship with dynamically linkable libraries. We have to statically link the binary, which causes the resulting binary to be quite large. This isn't the biggest deal, but isn't very user-friendly if you were looking to ship a user application. However, for a server-based app like mine, it really doesn't matter.

### Step 1: Install the Open-Source Toolchain

This part is very important. You need to use the open source Swift toolchain from [Swift.org](https://www.swift.org/install/macos/). This is different from the Swift toolchain that is installed with Xcode, and includes support for features like Embedded Swift and Swift SDKs. Installing an open source Swift version is really straightforwards with the new [Swiftly](https://www.swift.org/install/macos/swiftly/) tool. 

#### Using Swiftly

Follow the instructions on Swift.org to [install Swiftly](https://www.swift.org/install/macos/swiftly/) and the latest version of Swift.

#### Using an Installer

Download the install package from Swift.org and download the Package Installer .pkg file. Open the installer and it'll install a new `.xctoolchain` Xcode toolchain file on your system.

> This tripped me up for a while. When you run `swift` after installing a toolchain using this method, you'll still be using Xcode's version of Swift. You'll have to run the specific toolchain you just installed using `xcrun` like:
> ```bash
> xcrun --toolchain swift swift build -c release
> ```
> This may be an issue with my machine and my path settings. Having used `swiftly` since, it seems to work much better. I'd highly recommend using `swiftly`!

### Step 2: Install the Swift SDK

Swift makes downloading and installing the Swift SDK itself very easy. Grab the URL and checksum from Swift's install page.

```bash
swift sdk install <URL-or-filename-here> [--checksum <checksum-for-archive-URL>]
```

You can list installed Swift SDKs with `swift sdk list` and see more options with `swift sdk --help`. It doesn't matter which toolchain (Xcode or open source) you use to install the SDK, they'll install to the same spot.

>   Quick note, I've been made aware that there's two closely named concepts that are very different. *SDK*s are an Xcode/Clang concept, but *Swift SDK*s are what we're working with. I've gone back and edited this (as of Sept 9th, 2025) to make sure I've referenced the correct SDK concept!

### Step 3: Compile using the Swift SDK

Now that everything is installed, compiling the package is *very* easy. Make sure you're using the open source toolchain by running it using `xcrun` (yeah, I know that sentence didn't make sense. If someone has a suggestion for how I'm doing this wrong, *please* DM me).

Just run `swift build` with the specified Swift SDK and in release mode for performance.

```bash
xcrun --toolchain swift swift build --swift-sdk x86_64-swift-linux-musl -c release
```

## Captain, It's Wednesday

The second project I did was the [captainitswednesday.com](https://captainitswednesday.com) bot on [Bluesky](https://bsky.app/profile/captainitswednesday.com). This little app was **much** simpler. I used the [ATProtoKit](https://github.com/MasterJ93/ATProtoKit/tree/0.25.0) Swift library by [Christopher Riley](https://bsky.app/profile/cjrriley.com) to send posts for the Bluesky account and set up a really simple cron job to post every Wednesday at 9 a.m. The issue I had with this project was actually a compiler crash when using the previously discussed static Linux Swift SDKs. So I realized I'd have to go back to the original method for cross-compiling Swift, *Docker*.

## Method 2: Docker Containers

[Docker](https://docker.com) is a really cool tool. I've been digging into it recently, and I've known for a while that the Vapor community has had to use Docker to compile their applications for Linux cloud hosts before Swift really started building out tooling for both cross-compilation and even Linux as a target platform. There is actually a guide on Swift's website for [packaging Swift projects](https://www.swift.org/documentation/server/guides/packaging.html), which mentions being able to compile to Linux. However, I found that I still needed some more information after reading it, so I'll outline the steps I took here.

The Docker cross-compilation method uses a Docker container to compile your Swift project in the Docker container, then copies the executable file out of the container for use. It might be easier to just ship the Docker container with the compiled executable, but for my use case (and I'm sure others), I didn't want to run Docker; I just wanted an executable to kick off.

>   A note about architecture:
>
>   Each command listed in this section will contain a `--platform` flag to indicate the target architecture. Each example will compile to `x86` (`amd64`), swap that out with `arm64` to target an ARM CPU.

### Step 1: Download the target Docker container

The official Swift guide mentions a `swift:bionic` container that I think is obsolete. I'd suggest downloading the `swift:latest` package, which is an Ubuntu container with everything you need to use Swift pre-installed. There are other Linux flavors you could use if necessary (bookworm, AmazonLinux2, Fedora, etc.), but in most cases, you'll be compiling against the Linux standard libraries and system calls, which should stay the same between most distributions. For instance, compiling in the Ubuntu container worked fine for running on my Gentoo server.

```bash
docker pull swift:latest --platform linux/amd64
```

### Step 2: Compile & Copy Out

Now that we have the Swift container, Docker makes it really easy to spin up a container. This command will mount the current directory in the `/workspace` folder in the container and set it as the working directory.

We'll then run some bash commands in the container to: compile the Swift package in Release mode, delete the contents of the `.build/install` directory, and copy the compiled output to the `.build/install` directory.

```bash
docker run --platform linux/amd64 \
  --rm \
  -v "$PWD:/workspace" \
  -w /workspace \
  swift:latest \
  /bin/bash -cl '\
    swift build -c release --static-swift-stdlib && \
    rm -rf .build/install && \
    mkdir -p .build/install && \
    cp -P .build/release/CaptainItsWednesday .build/install/'
```

>   Note: Change the path of the `cp` step to match your target's name. In my case it was `CaptainItsWednesday`. You could also copy the entire `release` directory here if you need.

## Step 3: Profit

I have this whole step in a script named `deploy.sh` that then copies the resulting executable into my home server using `scp`

```bash
scp .build/install/CaptainItsWednesday khan@homeserver.local:/home/khan/
```

Pretty nice to have around. If you want to verify the resulting executable's target platform you can run `file` against it to check.

```bash
file .build/release/CaptainItsWednesday
> .build/install/CaptainItsWednesday: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, with debug_info, not stripped
```

Another tip is to add a stripping step to remove all unnecessary code from the final executable. That reduced my resulting executable from 100MB to 64MB. Still large, but a significant improvement. My final deploy script looks like this, including the copy to my home server and strip steps.

```bash
docker run --platform linux/amd64 \
  --rm \
  -v "$PWD:/workspace" \
  -w /workspace \
  swift:latest \
  /bin/bash -cl '\
    swift build -c release --static-swift-stdlib && \
    strip --strip-unneeded .build/release/CaptainItsWednesday && \
    rm -rf .build/install && \
    mkdir -p .build/install && \
    cp -P .build/release/CaptainItsWednesday .build/install/' \
&& scp .build/install/CaptainItsWednesday khan@homeserver.local:/home/khan
```

And it works on a test run!

![Captain its Wednesday screenshot](./screenshot.webp)

## Final Thoughts

Swift's cross-compilation capabilities have come a long way from only compiling using Docker. It's nice having these instructions down somewhere even as it continues to get better, and I expect I'll continue amending this post as the tooling gets better. Shoutout to the new Swiftly tool too, I got to try that out while I was writing this up  and it's a huge improvement.

It's very exciting to see the Swift devs continue to hammer away at Linux and cross-compilation. I think my only remaining pain point is the confusion surrounding the toolchain, SDKs, and why (even using Swiftly) you can only run the open-source toolchain using `xcrun`.

I continue to have a blast programming in Swift. The language feels 'right' in a way other languages have not. I'm extremely grateful to be a part of this community and I'm excited for Swift's tooling to continue to improve. It's a long way from where it was when I started using Swift back in Swift 4. It made both of these afternoon projects super fun and exciting.
