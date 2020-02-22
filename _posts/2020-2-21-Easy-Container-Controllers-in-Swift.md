---
layout: post
title: Easy Container Controllers in Swift
hide_title: true
tags: [Swift, iOS, UIKit]
excerpt: Create a container controller to separate and simplify your UIKit views.
author: thecoolwinter
published: false
---

# What are container controllers?

Container controllers are like a larger, older brother to the UIViewController. They come in extremely handy when dealing with things like Auth state and UIView transitions. UIKit already comes with a few container controllers pre-installed. Some examples of these are the `UINavigationController`, or the `UITabViewController`. Each of those controllers have one or more sub-controllers and help with things like transitions or UI that needs to stay similar between each of the sub-controllers they contain.

# Why should I spend the time to make one?

Container controllers do a few things that make life as a developer much easier. First, they naturally separate your UI code into two parts. Instead of having your `Auth.onSignOut()` function in your AppDelegate (which can get very messy, very quick among other reasons not to do that), you have the `Auth.onSignOut()` happen in a separated, clean container that can directly interact with it's sub-controllers without having to use any `window.controllers.first` junk.

# Sounds good to me. How do I do this?