---
title: Save Codable Dates In Firestore
tags: [Swift, Firebase]
excerpt: Avoid JSON decoding errors when using Dates with Firestore and Codable.
created_at: 2021-01-07
---

## Lets say we have a Codable object we want to save in Firestore

This object has `name`, and `dateUpdated` properties. The `dateUpdated` property is a `Date` object. The implementation looks like this:

```swift
class Name: Codable {
  var name: String
  var dateUpdated: Date
}
```

To make my life easier, I've added a custom init to this object to convert it from `[String: Any]` to a `Name` object.

```swift
extension Name {
  init(dictionary: [String: Any]) throws {
    let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    self = try decoder.decode(Self.self, from: data)
  }
}
```

Pretty easy! Now when I get a response from Firestore I can just convert it to my object like this.

```swift
if let document = snapshot.documents.first {
  let data = document.data()
  let name: Name? = try? Name(data)
}
```

And I have a function that converts the object into a dictionary to save it to firestore.

```swift
func dictionary() throws -> [String: Any] {
  let data = try JSONEncoder().encode(self)
  guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
    throw NSError()
  }
  return dictionary
}
```



## What's the problem?

If you try saving an object with a `Date` property to Firestore, Firestore automatically changes the `Date` to a `Timestamp`. This probably wouldn't be a problem, unless you're trying to decode that same object where you'll get the error:

```swift
"Invalid type in JSON write (FIRTimestamp)"
```

This is being caused because Swift's Foundation doesn't know how to decode Firestore's `Timestamp` type from JSON. 

## How do you fix it?

It's pretty simple actually, we just tell the `JSONDecoder` and `JSONEncoder` to use a special way of encoding/decoding dates. It's just a few line's change for each of the methods in the class.

```swift
extension Name {
  init(dictionary: [String: Any]) throws {
    let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    let decoder = JSONDecoder() // Change
    decoder.dateDecodingStrategy = .secondsSince1970 // Change
    self = try decoder.decode(Self.self, from: data) // Change
  }
  
  func dictionary() throws -> [String: Any] {
    let encoder = JSONEncoder() // Change
    encoder.dateEncodingStrategy = .secondsSince1970 // Change    
    let data = try encoder.encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
```

All this is doing is telling swift to save our `dateUpdated` date as a number instead of an actual date. This way, Firestore doesn't try to change any `Date` types to `Timestamps` and we don't get the aforementioned error.



The change made was instead of using a bare `JSONEncoder` or `JSONDecoder`, I changed it to use this:

```swift
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .secondsSince1970
```



This is applicable to other environments too. If you're building a server using swift, you can use those custom `JSONEncoder`/`JSONDecoder` date strategies to encode date types so you know what they'll look like on the server side. The other options for date strategies can be found in the [documentation](https://developer.apple.com/documentation/foundation/jsondecoder/2895216-datedecodingstrategy).

