struct BlogPost: Component {
    let post: BlogPostContents

    var body: some Component {
        Page(
            title: post.title,
            description: post.excerpt,
            path: post.linkPath,
            loadCodeStyles: true
        ) {
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
                        A("https://bsky.app/profile/khanwinter.com", ["target": "_blank"]) {
                            Constants.bskySVG
                        }
                    }
                }

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

                    Tag(
                        "script",
                        [
                            "defer": "",
                            "src": "https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js",
                            "integrity": "sha384-43gviWU0YVjaDtb/GhzOouOXtZMP/7XUzwPTstBeZFe/+rCMvRwr4yROQP43s0Xk",
                            "crossorigin": "anonymous"
                        ]
                    ) { EmptyComponent() }

                    Tag("script") {
                        """
                        document.addEventListener("DOMContentLoaded", function() {
                            renderMathInElement(document.body, {
                                delimiters: [
                                    {left: '$$', right: '$$', display: true},
                                    {left: '$', right: '$', display: false},
                                ],
                                throwOnError : true
                            });
                        });
                        """
                    }
                }

                post.markdown.html

                Tag("hr") { EmptyComponent() }

                Tag("div", ["class": "article-footer"]) {
                    P { post.createdAt.formatted(date: .abbreviated, time: .omitted) }

                    Tag("div", ["class": "avatar", "href": "/about.html"]) {
                        A("/about.html") {
                            Img(resourceName: "avatar.webp", alt: "Avatar Image", size: (24, 24))
                            Tag("span") { "Khan Winter" }
                        }
                        "·"
                        A("https://bsky.app/profile/khanwinter.com", ["target": "_blank"]) {
                            Constants.bskySVG
                        }
                    }
                }
            }
        }
    }
}
