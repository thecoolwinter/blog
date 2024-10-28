struct BlogPost: Component {
    let path: String

    var body: some Component {
        Page(loadCodeStyles: false) {
            Post(path: path)
        }
    }
}
