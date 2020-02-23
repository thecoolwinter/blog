---
layout: post
title: Easy Container Controllers in Swift
tags: [Swift, iOS, UIKit]
excerpt: Create a container controller to separate and simplify your UIKit views.
author: thecoolwinter
---

## What are container controllers?

Container controllers are like a larger, older brother to the UIViewController. They come in extremely handy when dealing with things like Auth state and UIView transitions. UIKit already comes with a few container controllers pre-installed. Some examples of these are the `UINavigationController`, or the `UITabViewController`. Each of those controllers have one or more sub-controllers and help with things like transitions or UI that needs to stay similar between each of the sub-controllers they contain.

## Why should I spend the time to make one?

Container controllers do a few things that make life as a developer much easier. First, they naturally separate your UI code into two parts. Instead of having your `Auth.onSignOut()` function in your AppDelegate (which can get very messy, very quick among other reasons not to do that), you have the `Auth.onSignOut()` happen in a separated, clean container that can directly interact with it's sub-controllers without having to use any `window.controllers.first` junk.

## Sounds good to me. How do I do this?

First we'll start out simple, just a UIViewController subclass with one property, the `displayedView` property.

```swift
import UIKit

class ContainerController: UIViewController {
  
  var displayedView: UIViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
}

```

Very simple.

#### Now, we want to make this as reusable and easy as possible, so we're going to add a few helper methods to UIViewController.

Make a new file for this extension and put the following code in.

```swift
import UIKit

extension UIViewController {
/*
  This method gives us a function to quickly add a child view controller,
  it takes care of adding the child, adding the view as a subview and then 
  telling the subview that it's moved to a new parent.
*/
	func add(_ child: UIViewController) {
  	addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }

/*
  This method makes it simpler to remove a child view controller.
*/
  func remove() {
// First we check if the parent view controller exists, 
// if not we can stop the whole thing right now.
  	guard parent != nil else { return }
		
// Here we enumerate through each subview telling them that their
// going to be removed and then removing them.
		children.forEach({ 
      $0.willMove(toParent: nil)
      $0.view.removeFromSuperview() 
      $0.removeFromParent() 
    })
		
// These tell this view controller that it will be moving to nil parent
// and then removes it from the parent view controller.
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}

```

Read through the comments above for more detail on this peice of code. Basically this extension makes it easier to add and remove child view controllers.

## Implementing the Container Controller.











