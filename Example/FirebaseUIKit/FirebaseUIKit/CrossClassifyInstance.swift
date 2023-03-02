import CrossClassify

extension CrossClassify {
    public static var shared: CrossClassify {
        let siteId = ProcessInfo.processInfo.environment["SITE_ID"] ?? ""
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
        return CrossClassify(siteId: siteId, apiKey: apiKey)
    }
}
