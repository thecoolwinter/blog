import Foundation

struct HomePage: Component {
    let postsDir: URL

    var body: some Component {
        let posts = JobHelpers.getAllPosts(postsDir: postsDir).sorted(by: { $0.post.createdAt > $1.post.createdAt })

        Page(loadCodeStyles: false) {
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
                                P { post.createdAt.formatted(date: .abbreviated, time: .omitted).uppercased() }
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