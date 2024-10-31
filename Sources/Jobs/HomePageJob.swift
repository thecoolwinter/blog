struct HomePageJob: Job {
    var title: String { "Create Home Page" }
    var handler: () throws -> Void = {
        let html = HTMLRenderer.render {
            HomePage(postsDir: postsDir)
        }

        try html.write(toFile: outDir.appending(path: "index.html").path(), atomically: true, encoding: .utf8)
    }
}
