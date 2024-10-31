struct AboutPageJob: Job {
    var title: String { "Create About Page" }
    var handler: () throws -> Void = {
        let html = HTMLRenderer.render {
            AboutPage()
        }

        try html.write(toFile: outDir.appending(path: "about.html").path(), atomically: true, encoding: .utf8)
    }
}
