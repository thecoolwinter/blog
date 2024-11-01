import Foundation

struct Head: Component {
    let title: String
    let description: String
    let path: String
    let loadCodeStyles: Bool

    init(title: String, description: String, path: String, loadCodeStyles: Bool = false) {
        self.title = title
        self.description = description
        self.path = path
        self.loadCodeStyles = loadCodeStyles
    }

    var body: some Component {
        Tag("head") {
            Meta("charset", "utf-8")
            Meta("viewport", "width=device-width, initial-scale=1, maximum-scale=5")
            Meta("color-scheme", "only light")

            Tag("title") { "Khan's Blog · \(title)" }
            Meta("description", description)
            Meta("robots", "index, follow")
            Meta("keywords", "Khan Winter, Swift, macOS, JavaScript, iOS, web development, blog, SwiftUI")

            MetaProperty("og:type", "website")
            MetaProperty("og:sitename", "Khan's Blog")
            MetaProperty("og:url", "https://khanwinter.com/\(path)")
            MetaProperty("og:title", "Khan's Blog · \(title)")
            MetaProperty("og:description", description)

            MetaProperty("twitter:url", "https://khanwinter.com/\(path)")
            MetaProperty("twitter:title", "Khan's Blog · \(title)")
            MetaProperty("twitter:description", description)

            if path == "index.html" {
                Tag("link", ["rel": "canonical", "href": "https://khanwinter.com/\(path)"])
            } else {
                Tag("link", ["rel": "canonical", "href": "https://khanwinter.com/"])
            }
            Tag("link", ["rel": "me", "href": "https://twitter.com/thecoolwinter"])
            Tag("link", ["rel": "me", "href": "https://mastodon.social/@thecoolwinter"])
            Tag("link", ["rel": "me", "href": "https://threads.net/thecoolwinter"])

            Tag("link", ["rel": "stylesheet", "href": "/assets/index.css"])
            Tag("script", ["src": "/assets/index.js"]) { EmptyComponent() }

            if loadCodeStyles {
                Tag("link", ["rel": "stylesheet", "href": "/assets/prism.css"])
                Tag("link", ["rel": "stylesheet", "href": "/assets/code-theme.css"])

                Tag("script", ["src": "/assets/prism.js", "defer": ""]) { EmptyComponent() }
            }

            // Hehe, preload the whole site. Makes this bitch SO fast at the cost of like a few kB
            Tag("link", ["rel": "prefetch", "href": "/index.html", "data-nav": "true"])
            Tag("link", ["rel": "prefetch", "href": "/about.html", "data-nav": "true"])
            // Stable ordering to avoid destroying cache.
            for post in JobHelpers.getAllPosts(postsDir: postsDir).sorted(by: { $0.post.createdAt > $1.post.createdAt }) {
                Tag(
                    "link",
                    [
                        "rel": "prefetch",
                        "href": "/" + post.url.deletingPathExtension().appendingPathExtension("html").path(),
                        "data-nav": "true"
                    ]
                )
            }
        }
    }
}
