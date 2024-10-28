---
title: Sort a List of Objects
tags: [Swift, UIKit, SwiftUI, Core Data, Realm]
excerpt: Learn how to store a sort order on a list of items saved in a database.
created_at: 2021-08-07
---

## Sorting Objects In A DB

Lists of objects can often be sorted by a variable, eg calendar events are often sorted by the date they are for. Like so:

```
Event 1: 10:00 AM
Event 2: 11:00 AM
Event 3: 12:00 PM
```

Sometimes though, we need to sort objects in a list that don't have an easy way to sort, or we need to allow users to sort the objects to their desire. The user will most likely expect his/her sort order to be kept, and we also can't just store an Array of objects in a db. 

The other problem is if we give all the objects a number value to sort by, we can't update <u>every single object</u> in the database with a new sort number. That's just impractical and a waste of compute time and energy.

The solution is to sort the items by a `Double` variable. The objects will look basically like this at first:

```
Item 1: 10.0
Item 2: 20.0
Item 3: 30.0
```

When the user moves Item 3 up a slot, we just give it a number between items 1 and 2, like this:

```
Item 1: 10.0
Item 3: 25.0 <- Inserted here
Item 2: 20.0
```

If a user moves Item 3 back down, we just add 10.0 to the biggest item's order, and get the list we started out with:

```
Item 1: 10.0
Item 2: 20.0
Item 3: 30.0
```

Finally, if the user moves Item 3 to the top of the list, we find a number between `0.0` and Item 1's order, and give it to Item 3:

```
Item 3:  5.0 <-- Halfway between 0 and 10
Item 1: 10.0
Item 2: 20.0
```

Pretty simple! We don't have to update every single item in the list, and `Double`s can be divided for a long time, so it will be rare to run out of space between items in the list.

This article will give an example of how to give users the ability to sort items and keep the sort order using Core Data in SwiftUI. This same method applies to any database/UI framework that allows you to sort your items by a `Double` type.

> There's also a fully functional example project [available for download here](https://github.com/thecoolwinter/SortDBExample) that implements the ideas talked about.

## Order Variable

The main idea behind this solution is having a variable on all our objects in the list that's a `Double` type. For this example, say we have a list of items that we're going to allow the user to sort at will. The `Item` object may look something like this:

```swift
struct Item {
  var id: UUID = UUID()
  var label: String
  var order: Double
}
```

Notice that we're adding an `order` variable as type `Double` to this object. In Core Data, this can be done super easily by just adding a variable of type `Double` to your .xcdatamodeld file.

When we go to fetch the `Todo`s we'll just sort them by the `order` variable. For Core Data this looks like this:

```swift
@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.order, ascending: true)], 
              animation: .default)
private var items: FetchedResults<Item>
```

## Updating The Order

There are 2 pieces of code we need to modify to make this actually work:

1. When an `Item` is added
2. When an `Item` is moved

### Added

When an `Item` is added, we need to give it an initial order value. The code may look something like below, where I'm just getting the biggest order value, and adding more onto it for the new object. If there aren't any `Item`s I just give it a value of `100.0`

```swift
func addItem() {
	withAnimation {
		let newItem = Item(context: viewContext)
    newItem.label = "New Item!"
    
    if items.count > 0 { // Check if there are items
			newItem.order = items.last!.order + 25.0 // Add some more to the order
		} else {
			newItem.order = 100.0 // Give some padding from 0.0 for later
		}

    try! viewContext.save()
	}
}
```

Awesome, now when items are added they will automatically go to the bottom of the list. If there are no items, we'll give ourselves some padding numerically for the next case.

### Moved

When an item is moved, things get a little more tricky. There are 3 paths here to handle:

1. The item is moved to the top of the list
2. The item is moved to the bottom of the list
3. The item is put somewhere in the middle

We'll always need to find an order value between two values to insert the item somewhere. 

For the three cases the `upper` and `lower` order values will be between:

1. 0.0 -> next list item
2. last list item -> last list item + 100.0
3. Next destination list item -> destination list item

In swift this looks like the following code

```swift
var upper: Double
var lower: Double

if destination == items.count {
    print("Appending to the end of the list")
    lower = items.last!.order
    upper = items.last!.order + 100.0
} else if destination == 0 {
    print("Inserting into the begining")
    lower = 0.0
    upper = items.first?.order ?? 100.0
} else {
    print("Inserting into the middle of the list")
    // Find the upper and lower sort around the destination and make some sort orders
    upper = items[destination - 1].order
    lower = items[destination].order
}
```

Then, we can get numbers between the upper and lower limits like

```swi
var newOrders: [Double] = stride(from: lower, to: upper, by: (upper - lower)/Double(sourceItems.count + 1)).map { $0 }
newOrders.remove(at: 0)
```

> We're handling the case where we're moving more than one item too. So if two items are inserted between 10.0 and 20.0 we should generate 12.5 and 17.5 to insert both the items in the correct spot.

Then, its a simple matter of updating the sort order of the objects!

```swift
var i = 0
source.forEach { index in
    items[index].order = newOrders[i]
    i += 1
}

try! viewContext.save()
```

Done! 🎉

Here's the code from the example project in action.

<video width="400" controls>
  <source src="/2021/08/07/video.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video> 
