extension String: Component {
    var body: some Component { fatalError() }
    var html: String { self }
}
