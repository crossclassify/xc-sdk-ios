import Foundation

struct PageTrack {
    let pageviewId = CrossClassify.randomString(length: 6)
    let pageName: String
    let url: URL?
}
