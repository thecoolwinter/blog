struct BlogPost: Component {
    let post: BlogPostContents

    var body: some Component {
        Page(loadCodeStyles: true) {
            Tag("article") {
                Tag("div", ["class": "article-header"]) {
                    P { post.createdAt.formatted(date: .abbreviated, time: .omitted) }

                    H(1) {
                        post.title
                    }
                    H(3) {
                        post.excerpt
                    }

                    Tag("div", ["class": "avatar", "href": "/about.html"]) {
                        A("/about.html") {
                            Img(resourceName: "avatar.webp", alt: "Avatar Image", size: (24, 24))
                            Tag("span") { "Khan Winter" }
                        }
                        "·"
                        A("https://twitter.com/thecoolwinter", ["target": "_blank"]) {
                            Constants.xSVG
                        }
                        A("https://threads.net/thecoolwinter", ["target": "_blank"]) {
                            Constants.threadsSVG
                        }
                    }
                }

                Tag("hr")

                if post.katex {
                    // Only load Katex on pages that need it.
                    Tag(
                        "link",
                        [
                            "rel": "stylesheet",
                            "href": "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css",
                            "integrity": "sha384-nB0miv6/jRmo5UMMR1wu3Gz6NLsoTkbqJghGIsx//Rlm+ZU03BU6SQNC66uf4l5+",
                            "crossorigin": "anonymous"
                        ]
                    ) { EmptyComponent() }
                    Tag(
                        "script",
                        [
                            "defer": "",
                            "src": "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js",
                            "integrity": "sha384-7zkQWkzuo3B5mTepMUcHkMB5jZaolc2xDwL6VFqjFALcbeS9Ggm/Yr2r3Dy4lfFg",
                            "crossorigin": "anonymous"
                        ]
                    ) { EmptyComponent() }
                }

                post.markdown.html
            }
        }
    }
}
