import Foundation

struct HomePageJob: Job {
    var title: String { "Create Home Page" }
    var handler: (JobParams) throws -> Void = { params in
        let html = HTMLRenderer.render {
            Page(loadCodeStyles: false) {
                Tag("ul") {
                    for post in Self.getAllPosts(params) {
                        let url = post.deletingPathExtension().appendingPathExtension("html").path()
                        Tag("li") { A(url) { url } }
                    }
                }
            }
        }

        try html.write(toFile: params.outDir.appending(path: "index.html").path(), atomically: true, encoding: .utf8)
    }
}
