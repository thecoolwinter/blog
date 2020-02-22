---
layout: post
title: Save Arrays of Objects in Realm
hide_title: true
tags: [Realm, Swift, iOS]
excerpt: Create a mapping field on a realm object to easily save and retrieve arrays of anything from a realm object.
author: thecoolwinter
published: true
---

# Save and retrieve arrays of objects in Realm Swift

### The problem: Realm only allows you to save lists of objects (like arrays) in the `List<T>` format.

For instance we'll take this dog object. The dog can have multiple Collars, but you have to store them in a list like so.

```swift
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
  
  	let collars = List<Collar>()
}

class Collar: Object {
  @objc dynamic var color = "Blue"
  @objc dynamic var favorite = false
}
```

This makes for slightly confusing code when trying to retrieve the collars from the dog and do other operations. However, we can abstract the list and make it an array property by adding one propery to the Dog object

```swift
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
  
  	var collars: [Collar] {
      get {
        return _collars.map{ $0 }
      }
      set {
        _collars.removeAll()
        _collars.append(objectsIn: newValue)
      }
    }
  	let _collars = List<Collar>()
}
```

We change the `collars` property to `_collars`, then make a new variable `collars` that realm wont track. 

This variable has two key parts: a getter, and a setter.

The getter simply maps the `_collars` object to an array and returns the array.

```swift
get {
  return _collars.map{ $0 }
}
```

The setter removes all the values using `.removeAll()` and then sets the `_collars` list from the given array.

Now we can use the `collars` property just like any other array. Just make sure to use it in a write block when writing the object to storage like so:

```swift
try! realm.write {
  dog.collars = [Collar(color: "Red", favorite: false), Collar(color: "Blue", favorite: true)]
}
```
