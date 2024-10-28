struct BlogPost: Component {
    let path: String

    var body: some Component {
        Page(loadCodeStyles: true) {
            Post(path: path)
        }
    }
}
