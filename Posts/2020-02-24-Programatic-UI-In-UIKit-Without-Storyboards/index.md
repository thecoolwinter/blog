---
title: Programatic UI in UIKit without Storyboards
tags: [Swift, UIKit]
excerpt: Use simple functions and layout anchors to create a simple UI without storyboards.
created_at: 2020-11-04
---

## Why are storyboards all that bad?

#### Answer: They're not
Really

, storyboards are super good at helping create UI. They make it easy to see exactly what you're building and work with constraints on each view. Sometimes though, it's easier to not use them. For more repetitive views, using storyboards will be a pain, having to link every single input and output to your `UIViewController` file, copy-pasting the whole thing. It leads to bugs and spaghetti code. 

Sometimes though, in an app with many views storyboards get messy and overloaded. It then becomes easier to use programmatic views and try not to use storyboards. Otherwise there's no disadvantage to using them.

## The best way that I've found to create View Controllers programmatically is this.

##### We'll be making a simple UI with a label, image and button as an example.

First, create your `UIViewController`. We'll call it `SampleViewController`

```swift
import UIKit

class SampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
```

There. Now lets add a few methods underneath the `viewDidLoad()` function.
```swift
private func setUpViews() {

}

private func setUpConstraints() {

}
```

These methods will hold our UI setup code. Let's add some variables to the top of this class to reference the 3 UI item's we're going to add
```swift
class SampleViewController: UIViewController {

var label: UILabel?
var button: UIButton?
var image: UIImage?

...
```

## Great! Now lets populate those variables.

In the `setUpViews()` function put this code in.
```swift
private func setUpViews() {

    label = UILabel()
    label?.text = "Hello World!"
    label?.translatesAutoresizingMaskToConstraints = false //Important to do with all views. If you don't set this to false, iOS will break all the constraints you will set.

    button = UIButton()
    button?.titleLabel.text = "Press Me"
    button?.tintColor = .systemBlue
    button?.translatesAutoresizingMaskToConstraints = false //Important
    button?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside) //Will return an error right now, ignore it as we haven't added the target function yet.

    image = UIImage()
    image?.image = UIImage(systemName: "gamecontroller")
    image?.translatesAutoresizingMaskToConstraints = false //Important

    //Add the views we just created to the view hierarchy
    view.addSubview(label!) //we can force-unwrap these because we know we just made them and they won't be nil.
    view.addSubview(button!)
    view.addSubview(image!)
}
```
Awesome! It's easy right? You have complete access to each view you're adding right here in this function. You modify it and add targets and images cleanly and knowing exactly what each one is going to be.

## Now lets add some constraints and lay out our UI.

We'll be using layout anchors to layout our views. They're much simpler to deal with than constraints.

In the `setUpConstraints()` function we defined before enter this.
```swift
private func setUpConstraints() {
    NSLayoutConstriant.activate([
        // Place the label in the top
        label.topAnchor.constraint(equalTo: view.topAnchor),
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

        // put the button centered below the label
        button.topAnchor.constraint(equalTo: label.bottomAnchor),
        button.widthAnchor.constraint(equalToConstant: 250),
        button.heightAnchor.constraint(equalToConstant: 100),
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        //put the image below the button
        image.topAnchor.constraint(equalTo: button.bottomAnchor),
        image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        image.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
    ])
}
```

The function `NSLayoutConstraint.activate([])` activates multiple constraints at once. So we use it here to activate all of ours at once.

**Make sure to add the `setUpViews()` and `setUpConstraints` to your `viewDidLoad()` function. Otherwise our code won't ever be executed :).**

Let's also add the button target code at the end of the file:
```swift
@objc func buttonPressed() {
    print("You Pressed the Button!")
}
```

## Sweet! You're all done! You've made a UIViewController with a UI without any storyboards.

---
Here's the full code:
```swift
import UIKit

class SampleViewController: UIViewController {

    var label: UILabel?
    var button: UIButton?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpViews()
        setUpConstraints()
    }

    private func setUpViews() {
        label = UILabel()
        label?.text = "Hello World!"
        label?.translatesAutoresizingMaskToConstraints = false //Important to do with all views. If you don't set this to false, iOS will break all the constraints you will set.

        button = UIButton()
        button?.titleLabel.text = "Press Me"
        button?.tintColor = .systemBlue
        button?.translatesAutoresizingMaskToConstraints = false //Important
        button?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside) //Will return an error right now, ignore it as we haven't added the target function yet.

        image = UIImage()
        image?.image = UIImage(systemName: "gamecontroller")
        image?.translatesAutoresizingMaskToConstraints = false //Important

        //Add the views we just created to the view hierarchy
        view.addSubview(label!) //we can force-unwrap these because we know we just made them and they won't be nil.
        view.addSubview(button!)
        view.addSubview(image!)
    }

    private func setUpConstraints() {
        NSLayoutConstriant.activate([
            // Place the label in the top
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            // put the button centered below the label
            button.topAnchor.constraint(equalTo: label.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 250),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            //put the image below the button
            image.topAnchor.constraint(equalTo: button.bottomAnchor),
            image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            image.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }

    @objc func buttonPressed() {
        print("You Pressed the Button!")
    }
}
```
