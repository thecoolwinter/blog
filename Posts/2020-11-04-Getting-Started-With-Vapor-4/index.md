---
title: Getting Started With Vapor 4.0
excerpt: Building a small Toggl Clone using Vapor.
created_at: 2020-11-04
tags: []
---

## What is Vapor?

[Vapor](https://vapor.codes/) is a modern server-side swift framework. It's community built , with tons of support for databases, hosting and user management. It's built on my favorite language **Swift**, meaning it's easy to learn, and has type safety built in.

I'll be building a small time tracking API similar to [Toggl](https://toggl.com/) over the course of a few posts, this is the first in this series.

## Get Started - Installation

#### Install Swift

If you're running a Mac, and already have Xcode installed. Great, you can skip this step. If not, go to the [App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12) and download it.

If you're running a Linux computer, you'll have to go over to the [Swift Downloads](https://swift.org/download/#using-downloads) page, and follow the instructions there for your distribution.

#### Install Vapor

We're going to need the vapor toolbox to run any project we make.

To install it on mac, you'll need [homebrew](https://brew.sh/) installed. Once installed, run `brew install vapor` and homebrew will install it all for you. Then when it's done, verify your installation by running `vapor -help`. You should see a list of available commands.

If you're on Linux, you'll have to build vapor from source. Just run these commands in a terminal.

```shell
git clone https://github.com/vapor/toolbox.git
cd toolbox
git checkout <desired version>
make install
```

Then verify it's installed correctly by running `vapor -help`.

## Creating a project

Now, we're going to set up our working directory. I'm going to build a time logging API, so I'll name my project TimeLog.

We'll just run `vapor new TimeLog` and follow the prompts given to you. You'll probably want to answer no to all the questions and get a bare-bones template to get started. For that, you can add a `-n` flag to the end of the prevous command like this `vapor new TimeLog -n`.

Sweet! Now you have an empty vapor project!

## Get a Database Running

I'm going to be using the Postgres database, as it's the one I have the most experience with. Vapor [supports](https://github.com/vapor/sqlite-nio) [tons](https://github.com/vapor/fluent-mongo-driver) [of](https://github.com/vapor/mysql-nio) [databases](https://github.com/vapor/postgres-nio). So you should be able to follow along with this tutorial no matter which one you choose.

If you don't have any databases installed, I'd recommend Postgres. [This gist](https://gist.github.com/ibraheem4/ce5ccd3e4d7a65589ce84f2a3b7c23a3) helped me a lot when I first installed it.

Since I'm using Postgres, I've created a database named `time-table` and opened the database to the url `postgres://<Admin-Name>:@localhost:5432/time-table`. Since this isn't goint to be a public project quite yet, I left off giving the database a password. If you're planning on releasing this server to the world, *you need a password*.

Once you have the url of your database, make a `.env` file in the root directory of your project. Then, insert the url you just made like this `DB_URL=postgres://<Admin-Name>:@localhost:5432/time-table` on the first line. Then you're all set with your database.

## Finally, Swift

#### Dependencies

Make an Xcode project by running `vapor xcode` in your project's directory.

For this series, I'm going to be using a few SPM packages. If you're following along, install them by opening the `Package.swift` and adding these three dependencies below `.product(name: "Vapor", package: "vapor"),`:

```swift
.product(name: "Fluent", package: "fluent"),
.product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
.product(name: "JWT", package: "jwt")
```

Then, below where it says `.package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),` add these lines.

```swift
.package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
.package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
.package(url: "https://github.com/vapor/jwt.git", from: "4.0.0-rc.1"),
```

This will install Fluent, Vapor's database framework, JWT, which we'll use for user authentication and the Fluent Postgres Driver so we can use our Postgres database.

#### Connect the database

In your `configure.swift` file under Sources > App add the following extension to the top of the file.

```swift
extension Application {
    static let databaseURL = URL(string: Environment.get("DB_URL")!)!
}
```

This uses the `.env` file we made earlier to get the database url. You can use `.env` files for other things like admin keys and passwords you don't want plain in your code for anyone to see.

Now lets use that url in the `configure(_ )` function add the following line to the top.

```swift
try app.databases.use(.postgres(url: Application.databaseURL), as: .psql)
```

Right now, Xcode will throw an error, so import the required dependencies at the top of the file.

```swift
import Fluent
import FluentPostgresDriver
import JWT
```



## Conclusion

There we go! You now have an empty vapor project with an empty database and all the dependencies installed. I'll be making a part 2 soon for this series, when it's up it'll be linked right here!
