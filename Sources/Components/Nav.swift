struct Nav: Component {
    var body: some Component {
        Tag("nav") {
            Tag("ul") {
                Tag("li") { A("/index.html") { "Posts" } }
                Tag("li") { Tag("button", ["onclick": "navRandom()"]) { "Random" } }
                Tag("li") { A("/about.html") { "About" } }
                Tag("li") { A("/rss.html") { "RSS" } }
            }
        }
    }
}
