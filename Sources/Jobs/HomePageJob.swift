import Foundation

struct HomePageJob: Job {
    var title: String { "Create Home Page" }
    var handler: (JobParams) throws -> Void = { params in
        let html = HTMLRenderer.render {
            HomePage(postsDir: params.postsDir)
        }

        try html.write(toFile: params.outDir.appending(path: "index.html").path(), atomically: true, encoding: .utf8)
    }
}
