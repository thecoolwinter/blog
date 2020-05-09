---
layout: post
title: Scripting With Swift
hide_title: false
tags: [Swift, scripting]
excerpt: Make fast, simple scripts with your favorite language.
author: thecoolwinter
published: true
sitemap:
  lastmod: 2020-05-05
categories: snippets
---

## Create the script

Launch the terminal and `cd` into the directory you want your script to be. Eg: `cd Desktop/Scripts`.

Enter `touch main.swift` to create a new swift file.

Then, to make it executable change the chmod on the file with `chmod +x main.swift`. This makes it so your computer recognizes the file as something that can be run. Instead of something to read.

Launch Xcode (or another editor) and open your new swift file. Then add this bit to the top:

```swift
#!/usr/bin/swift // This is crucial. Without it your script will not run.

print("Hello World")
```

Now, go back to your terminal and run the script using `./main.swift`. It should read something like

```bash
user@Computer ~ % ./main.swift 
Hello World
user@Computer ~ % 
```



## You've done it!

Now you have a running Swift script. You can add anything you want to the script, except things like UIKit or SwiftUI. Those won't work and you'll want Xcode's help using them.

Some ideas on what you could do:

- Twitter bots
- Schedule a backup
- Automatically copy-paste large folders
- Automatically push a git repository
- Retreive stock market data and save it in a local database
- So much more!



### One more thing to note

Xcode's autocomplete will not work for scripts. So what I do is create a playground, write and debug the script and then when it's ready copy-paste it into the script file you just made. Then, you have autocomplete while writing the script.

