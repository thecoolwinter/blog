---
layout: post
title: Increasing Tree Performance in Swift
hide_title: false
tags: [Swift]
excerpt: Tree structures in Swift often suffer from performance issues due to retain/release overhead. Learn how to negate some of this in your own code.
author: thecoolwinter
published: true
sitemap:
    lastmod: 2023-12-25
categories:
---

Trees are extremely common data structures in the world of programming. Being the extremely versatile data structures they are, they can be used to represent buckets in a [hash map](https://medium.com/geekculture/a-deep-dive-into-java-8-hashmap-a976aca22f9b), store [lines for a code editor](https://github.com/rebornix/PieceTree), or perform simple [compression](https://en.wikipedia.org/wiki/Huffman_coding). Because of this, 

Swift users may be disheartened to find that by default tree structures in Swift can be rather slow. If you are like me, you may have implemented a complex tree in Swift, only to find it performs badly when benchmarking it.

Take this example tree. 

```swift
class Tree<T> {
    var root: Node<T>?
}

class Node<T> {
    init(data: T, left: Node<T>? = nil, right: Node<T>? = nil) {
        self.data = data
        self.left = left
        self.right = right
    }

    let data: T
    var left: Node<T>?
    var right: Node<T>?
}
```

## Retain/Release

## Unmanaged

## Why not use value types?

Why not just use a `struct` to represent nodes? Maybe we could simply get rid of all retain/release overhead by getting rid of the need for ARC entirely. While this isn't a bad idea, Swift prevents us from creating tree structures using `struct`s. Say you were to attempt to implement this like the example shown below, you would quickly get the error.

`❌ Value type 'Node<T>' cannot have a stored property that recursively contains it`

```swift
struct Node<T> {
    let data: T
    var left: Node<T>? // ❌ ...
    var right: Node<T>? // ❌ ...
}
```

The other option would be to use an enum with an indirect case. This tells the compiler to upgrade the enum type to make it able to handle cases

```swift
# Based on the example found here
# https://forums.swift.org/t/who-benefits-from-the-indirect-keyword/20167/5

class Tree<T> {
    var root: Node<T> = .empty
}

enum Node<T> {
    case empty
    indirect case node(left: Node, value: T, right: Node)
}
```

