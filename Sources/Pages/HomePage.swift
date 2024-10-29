import Foundation

struct HomePage: Component {
    let postsDir: URL

    var body: some Component {
        let posts = JobHelpers.getAllPosts(postsDir: postsDir).sorted(by: { $0.post.createdAt > $1.post.createdAt })

        Page(loadCodeStyles: false) {
            Tag("ul") {
                for (post, path) in posts {
                    let url = path.deletingPathExtension().appendingPathExtension("html").path()
                    Tag("li") {
                        A(url) {
                            H(3) { post.title }
                            P { post.excerpt }
                        }
                    }
                }
            }
        }
    }
}