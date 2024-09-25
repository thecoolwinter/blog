---
layout: post
title: Drag and Drop Deep Dive
hide_title: false
tags: [Swift, UIKit]
excerpt: Take a deep dive into UIKit's drag and drop APIs to take your apps interaction to the next level..
author: thecoolwinter
published: false
sitemap:
  lastmod: 2021-07-01
categories: 
---

## Drag And Drop 🤿

One of the most intuitive things about Apple products is drag and drop. Users expect to be able to reorder tables and collections by holding down hard and dragging in a direction. 

However, this API can seem hard to understand and is even less well documented. There is an example project from Apple, but its only helpful for the minimal drag and drop interaction. 

My goal here is to give three levels of understanding of the Drag and Drop API.

1. 🧐 Basics
2. 🧠 Intermediate
3. 🤯 God-Tier

Each section starts with a small GIF of what the section will bring you to, you can skip to each one depending on how much time you want to spend refactoring for drag and drop.

I'll also be using `UITableView` for all the examples here, however the API is nearly the same for `UICollectionView`, you'll just have to adjust some names.

## 🧐 Basics

