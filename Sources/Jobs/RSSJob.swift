//
//  RSSJob.swift.swift
//  blog
//
//  Created by Khan Winter on 1/7/26.
//

import Foundation
import HTMLEntities

struct RSSJob: Job {
    var title: String { "RSS Job" }
    var handler: () throws -> Void = {
        let header = #"<?xml version="1.0" encoding="utf-8"?><feed xmlns="http://www.w3.org/2005/Atom">"#
        let end = #"</feed>"#
        let allPosts = JobHelpers.getAllPosts(postsDir: postsDir).sorted(by: { $0.post.createdAt < $1.post.createdAt })

        let feed = ATOMRenderer.render {
            Tag("id") { "https://khanwinter.com/" }
            Tag("title") { "Khan's Blog" }
            Tag("subtitle") { "Khan's Online Web Log (aka: my blog)!" }
            if let updatedAt = allPosts.compactMap({ fileModificationDate(url: $0.url) }).max() {
                Tag("updated") { formatDate(updatedAt) }
            }
            Tag("author") {
                Tag("name") { "Khan Winter" }
                Tag("uri") { "https://bsky.app/profile/khanwinter.com" }
            }
            Tag("link", ["rel": "self", "href": "https://khanwinter.com/feed.rss", "type": "application/rss+xml"])
            Tag("link", ["href": "https://khanwinter.com/"])
            Tag("link", ["href": "https://bsky.app/profile/khanwinter.com"])
            Tag("link", ["href": "https://github.com/thecoolwinter"])
            Tag("category", ["term": "programming"])
            Tag("category", ["term": "swift"])
            Tag("category", ["term": "macos"])
            Tag("category", ["term": "ios"])
            Tag("category", ["term": "apple"])
            Tag("rights") { "Copyright © Khan Winter 2025" }

            for (post, path) in allPosts {
                Tag("entry") {
                    Tag("id") { "https://khanwinter.com/\(post.linkPath)" }
                    Tag("title") { post.title }
                    Tag("link", ["rel": "alternate", "href": "/" + post.linkPath])
                    Tag("published") { formatDate(post.createdAt) }
                    Tag("summary") { post.excerpt }
                    Tag("content", ["type": "html"]) {
                        post.markdown.html.htmlEscape()
                    }
                }
            }
        }

        try feed.write(to: outDir.appending(path: "feed.rss"), atomically: true, encoding: .utf8)
    }

    static func formatDate(_ date: Date) -> String {
        Date.ISO8601FormatStyle(includingFractionalSeconds: true).format(date)
    }

    static func fileModificationDate(url: URL) -> Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch {
            return nil
        }
    }
}
