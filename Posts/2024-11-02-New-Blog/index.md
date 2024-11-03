---
title: New Blog, New Me
tags: [Swift]
excerpt: I redesigned my blog, in Swift.
created_at: 2024-11-03
---

## Why Restart?

Previously, my blog was published using the popular [Jekyll](https://jekyllrb.com/) static site generator. While Jekyll worked well for a long time, it has became a serious pain to maintain.

I often have long periods of time where I don't post. Ideally when I come back after a year of not posting I'd like my tools to work just as well as they did previously. Jekyll did not meet this requirement well. With Ruby increasingly losing popularity and Gems requiring some serious finagling, I often had to completely reinstall the entire tool and all dependencies every time I wanted to write a new post. This was not working well.

Therefore, my new system had the following requirements:
- **No or few outside dependencies.** Whatever dependencies are used need to be well known to me and well known what they do.
- **Familiar tools.** I need whatever this is built on to be entirely familiar to me. At this point (2024) this likely means **Swift and JavaScript**.
- **Static HTML.** I dislike overuse of JS libraries. This means no TailwindCSS, no React, only CSS, JS and HTML.

## Existing Tools

If you're familiar with the Swift ecosystem, you may have heard of the tool [Publish](https://github.com/JohnSundell/Publish?tab=readme-ov-file) by [John Sundell](https://www.swiftbysundell.com/). This looks like it was going to be a perfect tool! It is actually a really nice tool. It's well built, entirely Swift, and fairly extendable. However, while it likely works for a lot of developers and blogs, mine needed some customizations that the library did not support.

Publish's markdown rendering engine [Ink](https://github.com/JohnSundell/Ink/tree/master) though, turned out to be perfect. It did require some modification to support LaTeX, but it's very fast and I was very surprised to find that it didn't rely on any C libraries like cmark. This ended up being one of two dependencies I allowed and I'm very thankful for the work John has done on this package.

## Swift Result Builders

Swift seems the obvious choice for building my own blog. I've been in love with the language for years now, and it continues to improve. One of the features that I've been eyeing for a long time but hadn't been able to dig into myself is [Result Builders](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators/#Result-Builders).

Using result builders for HTML has been well documented, and I think it's perfect for this job. My goal was to make some Swift syntax that can compile into HTML. Ideally it should look kind of like SwiftUI, and it shouldn't be a hinderance to maintaining or building the website itself.

The core of my website is the following protocol:
```swift
protocol Component {
    associatedtype Body: Component

    @HTMLBuilder
    var body: Self.Body { get }

    var html: String { get }
}

extension Component {
    var html: String { body.html }
}
```

This allows me to define components that can optionally provide HTML contents. Similar to SwiftUI, I defined a `TupleComponent` for the result builder to use. This one is fun because it uses Swift's new parameter packs to take multiple types of components in the initializer. I did have to use a `[any Component]` in one spot, and I'd very much like to not have to do that but I'll revisit that in the future.
```swift
struct TupleComponent: Component {
    init<each Content>(_ content: repeat each Content) where repeat each Content: Component {
        func buildHTML<T: Component>(_ item: T, html: inout String) {
            if T.self != EmptyComponent.self {
                html += item.html
            }
        }
        var value = ""
        repeat buildHTML(each content, html: &value)
        self.html = value
    }

    init(_ components: [any Component]) {
        self.html = components.filter { type(of: $0) != EmptyComponent.self }.map { $0.html }.joined()
    }

    var body: some Component {
        fatalError("")
    }

    var html: String
}
```

Also similar to SwiftUI, some components need to not have their children evaluated. In the previous example, `TupleComponent`'s `body` compiles to `Never` but still produces HTML using it's children. To get around this I used Swift's typing system to extend `Never` to be a component. While I was at it I made an `EmptyComponent` similar to SwiftUI's `EmptyView` to help myself avoid `fatalError`s.
```swift
extension Never: Component {
    var body: some Component { self }
    var html: String { "" }
}

struct EmptyComponent: Component {
    var body: some Component { fatalError() }
    var html: String { fatalError() }
}
```

This component type made simple HTML tags easy to make Swift-y syntax for, and allowed for nesting content easily.
```swift
struct A<Content: Component>: Component {
    let url: String
    let content: () -> Content

    init(_ url: String, @HTMLBuilder content: @escaping () -> Content) {
        self.url = url
        self.content = content
    }

    var body: some Component {
        content()
    }

    var html: String {
        return "<a href=\"\(url.path()\">" + content().html + "</a>"
    }
}
```

Then, because I was using a protocol as my base type, I was able to extend some standard lib types for my HTML builder. One key thing is Strings. Again, I used that `Never` extension to make this possible, as Strings won't ever have HTML children to evaluate.
```swift
extension String: Component {
    var body: some Component { fatalError() }
    var html: String { self }
}
```

Finally, using that I was able to define a result builder that combines components and allows for the syntax I was aiming for.
```swift
@resultBuilder
enum HTMLBuilder {
    static func buildBlock<each Content>(_ content: repeat each Content) -> TupleComponent where repeat each Content: Component {
        TupleComponent(repeat each content)
    }

    static func buildOptional(_ component: TupleComponent?) -> TupleComponent {
        if let component {
            component
        } else {
            TupleComponent([EmptyComponent()])
        }
    }

    static func buildEither<Content: Component>(first component: Content) -> Content {
        component
    }

    static func buildEither<Content: Component>(second component: Content) -> Content {
        component
    }

    static func buildArray(_ components: [any Component]) -> TupleComponent {
        TupleComponent(components)
    }
}
```

To actually generate the HTML document I just added a small function that uses the `.html` property on the `Component` type. This also adds a few common sense things for an HTML document like the language, HTML5 support, etc.
```swift
enum HTMLRenderer {
    static func render<Content: Component>(@HTMLBuilder page: () -> Content) -> String {
        "<!DOCTYPE html><html lang=\"en\" data-theme=\"light\">" + page().html + "</html>"
    }
}
```

This is slightly different from other methods I've seen around. The primary difference is the use of a root protocol type for each component, rather than inheritance from a class. I also wanted a system very similar to SwiftUI, in that there is no `children` array on any components. Instead, each component is a distinct element in the hierarchy of the page.

## But Why?

A good question to ask is is this effort worth it? I certainly think so. This resulted in a syntax that lets me express the HTML content of the webpage, while mixing in Swift logic that is never exposed to the browser.

For example, after a little more work the entire home page is represented using just this component.
```swift
struct HomePage: Component {
    var body: some Component {
        let posts = /* Get All Posts */

        Page(title: "Posts", description: "Khan Winter's Blog Posts", path: "index.html", loadCodeStyles: false) {
            Tag("div", ["class": "home"]) {
                Tag("div", ["class": "home-header"]) {
                    Img(resourceName: "avatar-large.webp", alt: "Avatar", size: (128, 128))
                    P { "Khan's Online Web Log (aka: my blog)!" }
                }

                Tag("ul") {
                    for (post, path) in posts {
                        let url = path.deletingPathExtension().appendingPathExtension("html").path()

                        Tag("li") {
                            A(url) {
                                P { post.createdAt.formatted() }
                                H(3) { post.title }
                                P { post.excerpt }
                            }
                        }
                    }
                }
            }
        }
    }
}
```

The largest benefit being able to use logic like for loops, variables, and branches directly in the page's code.
```swift
for (post, path) in posts {
    // ...
}
```

To me, this is very appealing. This is written in raw Swift, meaning as long as I have a Swift compiler on my machine it'll work. It also generates static HTML, with dynamic structure like loops and branches performed without JavaScript or an ugly syntax like Liquid. It meets the last goal I set for myself by not having any unecessary dependencies (Ink is pure Swift, *doesn't even need Foundation*).

So yeah, for my use case and my blog it was very worth the effort. On top of that, I got to explore Result Builders! You can check out the entire site on [my GitHub](https://github.com/thecoolwinter) if you'd like to check out more.

## _Bun_dling
 
The last thing I wanted was to minify my website's assets. There's a few lines of JS and CSS for highlighting code, displaying Math, etc. I've liked [esbuild](https://esbuild.github.io/) in the past so I decided to run esbuild on each file using [Bun](https://bun.sh/) (instead of NodeJS). The speed Bun provided is awesome. It's so fast that the script I made to minify all the JS and CSS files was moved to be in the main loop when generating the site rather than something that happens only when I deploy. Serious props to the team at Bun. Figured I'd share that while I was at it.

## CloudFlare

I'm not only moving domains and site generators, but also my hosting provider. I've used Github pages and Netlify in the past, and while I don't have any issue with them in particular they have some rough edges a few years in. Netlify is nice, but they've clearly adjusted their target audience to larger businesses. Most of the features they provide just don't apply to a little site like mine (beyond the CDN). Github Pages is pretty much perfect, but not transparent enough for my liking. I prefer to know when my content will be live after deploying it.

I initially was going to just host my static files in R2, CloudFlare's block storage offering. While setting that up I noticed they offer a static site hosting option which I tried out. So far, I've loved it. My site's download speed is faster than either Github or Netlify. They offer unlimited bandwidth, and DNS setup with them was faster than any other provider I've worked with. I don't usually give shoutouts for things like this but CloudFlare has been awesome to work with so far.

## Last Thing - Page Preloading

After all this work, all of the HTML, JS, and CSS for my site (not including images and videos) is only 0.33MB on disk uncompressed (_**97KB compressed using ZSTD**, CloudFlare's default compression mechanism_). Each new page is roughly 18KB uncompressed, which is nothing to download for most internet connections. Well, HTML has this nice feature that allows you to [pre-fetch pages for navigation](https://developer.mozilla.org/en-US/docs/Web/Performance/Speculative_loading#link_reldns-prefetch). Inspired in part by this [Youtube Video](https://www.youtube.com/watch?v=-Ln-8QM8KhQ), I decided to preload the entire blog on each page. 

Give it a try yourself! If you've made it this far. Clicking the "Random" navigation button a few times really shows off how zippy it is. Ironically, that's what powers that "Random" nav button. It uses the cached pages as the list to choose randomly from!

Is this tidbit useful anywhere else in any other context? No. But it's really funny to me to make every visitor download and cache the entire blog just to save a few milliseconds loading the post they're looking for 😉.

## Conclusion

So that's the post. New domain, new blog, new me! This has mostly been my rambling about some cool Swift features and a few things I found while rewriting this website. I hope it was worth the read!
