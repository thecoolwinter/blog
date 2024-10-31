import Foundation
class Balls {

}
struct Head: Component {
    let loadCodeStyles: Bool

    init(loadCodeStyles: Bool = false) {
        self.loadCodeStyles = loadCodeStyles
    }

    var body: some Component {
        Tag("head") {
            Tag("meta", ["charset": "utf-8"])
            Tag("meta", ["name":"viewport", "content": "width=device-width, initial-scale=1, maximum-scale=1"])
            Tag("meta", ["name": "color-scheme", "content": "dark light"])

            Tag("title") { "Khan's Blog" }

            Tag("link", ["rel": "stylesheet", "href": "/resources/index.css"])
            Tag("script", ["src": "/resources/index.js"]) { EmptyComponent() }

            if loadCodeStyles {
                Tag("link", ["rel": "stylesheet", "href": "/resources/prism.css"])
                Tag("link", ["rel": "stylesheet", "href": "/resources/code-theme.css"])

                Tag("script", ["src": "/resources/prism.js"]) { EmptyComponent() }
            }

            Tag("link", ["rel": "prefetch", "href": "/index.html", "data-nav": "true"])
            Tag("link", ["rel": "prefetch", "href": "/about.html", "data-nav": "true"])
            for post in JobHelpers.getAllPosts(postsDir: postsDir) {
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