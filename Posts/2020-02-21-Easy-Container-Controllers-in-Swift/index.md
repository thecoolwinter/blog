---
title: Easy Container Controllers in Swift
tags: [Swift, iOS, UIKit]
excerpt: Create a container controller to separate and simplify your UIKit views.
created_at: 2020-02-23
---

## What are container controllers?

Container controllers are like a larger, older brother to the UIViewController. They come in extremely handy when dealing with things like Auth state and UIViewController transitions. UIKit already comes with a few container controllers that you most likely know very well. Some examples of these are the `UINavigationController`, or the `UITabViewController`. Each of those controllers have one or more sub-controllers and help with things like transitions or UI that needs to stay similar between each of the sub-controllers they contain.

## Why should I spend the time to make one?

Container controllers do a few things that make life as a developer much easier. First, they naturally separate your UI code. Instead of having your `Auth.onSignOut()` function in your AppDelegate (which can get very messy, very quickly), you have the `Auth.onSignOut()` happen in a separated container that can directly interact with it's sub-controllers without having to use any `window.controllers.first` junk.

## First we need a few extensions.

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

Here's the main code of the controller.

```swift
import UIKit

class ContainerController: UIViewController {
	
  static let shared = ContainerController()
	
  var displayedView: UIViewController?
	
  override func viewDidLoad() {
    super.viewDidLoad()
		
    if displayedView == nil {
      displayedView = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
      add(displayedView!)
    }
  }
	
  public func transitionTo(_ view: UIViewController) {
    if displayedView != nil{
      displayedView!.remove()
    }
    add(view)
    displayedView = view
  }
}
```

Simple. In it we give a simple UIViewController with one method called `transitionTo(_ view:)` which can be called by outside controllers to change what view is displayed.

We also added a default view to be displayed in the `viewDidLoad()`. It just makes sure that when we initialize this class it automatically populates the `displayedView` variable. In this example I intitialize the root controller from the `main` storyboard, but you can replace it with any view controller or even omit this code entirely.

Also! I created a singleton by adding a `static let shared = ContainerController()` variable. You can read more about singletons [here](https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift) but they basically make it so we can keep track of one container controller for the entire app.

<small>TL;DR: Some people dislike singletons. However, in this case the ability to access the container controller from anywhere in your app without having to implement a delegate method or callback into every single view controller greatly outweighs the tiny bit of overhead a singleton creates. </small>

## Sweet. How do I use it?

Really easily. The main way I use it is in my AppDelegate (or SceneManager) like so:

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    var controller: UIViewController!
		
    let container = ContainerController.shared
		
    // In this example I'm using FirebaseAuth for authentication.
    // I check if a user is logged in, and if they are I send them
    // to the "Admin" view. Otherwise they go to the "Auth" view.
    if Auth.auth().currentUser != nil {
      
      let storyboard = UIStoryboard(name: "Admin", bundle: nil)
      controller = storyboard.instantiateInitialViewController()!
      
    } else {
      
      let storyboard = UIStoryboard(name: "Auth", bundle: nil)
      controller = storyboard.instantiateInitialViewController()!
      
    }
		
    // Make the container the root view controller.
    self.window?.rootViewController = container
    self.window?.makeKeyAndVisible()
        
    // Transition to the pre-defined controller
    container.transitionTo(controller)
    
    return true
  }

}
```

Really fairly simple to use. It can also be used from a view controller after the app is already running. To access the container at the root one can simply use `ContainerController.shared`.

------

This post was heavily inspired by John Sundell's post [here](https://www.swiftbysundell.com/articles/custom-container-view-controllers-in-swift/). Go check it out, he's an amazing writer and developer.





