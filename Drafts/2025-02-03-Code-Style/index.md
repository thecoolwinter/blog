---
title: Code Style Is Code Quality
tags: [Swift, Javascript]
excerpt: Exploring the idea that changing code style can improve the quality of code programmers write.
created_at: 2025-02-03
---

-   Style is quality, not just readability
-   The mental model
-   Linting encourages better thought-out logic
-   Testing

Core idea: **Code style is a reflection of our mental programming model. Improving code style can improve the code we write in any context.**



## Code Style *Is* Code Quality

As a developer, I often find that I think about code style being as simple as something a linter can split out. It's spaces vs. tabs, hamburger style or hotdog style functions. Recently though, I've been exploring changing my own code style in whatever language I'm using in an attempt to see how it can improve not just the *readability* of my code, but the *quality* of my code.

I think the simplified view of code style is common among programmers. When jumping into a new project one of the first things we may ask is "tabs or spaces". This allows us to conform to the rest of the project's code, improving our ability to share and read code written by others. The benefits of code style for readability and share-ability this have been explored enough and isn't what I'm looking to talk about here.

Instead, I'd like to introduce the notion that code style *is* code quality. They are one and the same, and go beyond whether or not you put a newline before your curly braces. Code style determines how programs are structured and logic is written. It's a reflection of the mental model a programmer is using while writing code. I put forward that if a programmer changes their code style, they can improve their own mental model of programs and write higher quality code.

## What Style Rules Make Programs 'Better'?

In recent conversations with a friend, we discussed how their idea of code style was to follow a strict set of rules that ideally makes it impossible to make mistakes. This idea was appealing, and we have since explored numerous code style rules that have helped both of us write better code.

As a concrete example, take this rule:

> Never use "`else if`" statements

On the surface, some might balk at the idea of getting rid of those precious logic branches. "Why have `else if` if you never use it?" right?
