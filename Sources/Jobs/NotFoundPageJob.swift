struct NotFoundPageJob: Job {
    var title: String { "Create Not Found Page" }
    var handler: () throws -> Void = {
        let html = HTMLRenderer.render {
            Page(title: "Not Found", description: "404 Page", path: "404.html", loadCodeStyles: false) {
                P { "Sorry, that page wasn't found." }
                A("index.html") { "Navigate To Posts" }
            }
        }

        try html.write(toFile: outDir.appending(path: "404.html").path(), atomically: true, encoding: .utf8)
    }
}
