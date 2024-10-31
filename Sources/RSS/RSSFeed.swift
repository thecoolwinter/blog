import Foundation

struct RSSFeed {
    struct FeedItem {
        let title: String
        let excerpt: String
        let author: String
        let createdAt: Date
        let html: String
        let path: String
    }

    func generate(_ items: [FeedItem]) -> String {
        // TODO: RSS Feed!
        return ""
    }
}
