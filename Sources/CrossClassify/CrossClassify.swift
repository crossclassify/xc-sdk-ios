import Foundation
import FingerprintPro
import FingerprintJS
import SwiftUI

public final class CrossClassify {
    
    private var siteId: String
    private var apiKey: String
    public var navigationTracker: NavigationTracker
    public var formInteractionTracker: FormInteractionTracker
    
    
    public init(siteId: String, apiKey: String) {
        self.siteId = siteId
        self.apiKey = apiKey
        let matomoTracker = MatomoTracker(siteId: siteId, baseURL: URL(string: "\(CrossClassify.baseUrl)/matomo.php")!, apiKey: apiKey)
        matomoTracker.logger = DefaultLogger(minLevel: .error)
        self.navigationTracker = NavigationTracker(matomoTracker)
        self.formInteractionTracker = FormInteractionTracker(matomoTracker)
        Task {
            let client = FingerprintProFactory.getInstance("nLvTePYiYEFERqTHoSZ7")
            self.navigationTracker.matomoTracker.userId = try? await client.getVisitorId()
            if self.navigationTracker.matomoTracker.userId == nil {
                let configuration = Configuration(version: .latest, stabilityLevel: .optimal, algorithm: .sha256)
                let fingerprinter = FingerprinterFactory.getInstance(configuration)
                self.navigationTracker.matomoTracker.userId = await fingerprinter.getFingerprint()
            }
        }
    }
    
    public func track(pageName: String, url: URL? = nil, formName: String? = nil, view: UIView? = nil) {
        formInteractionTracker.stopTrack()
        navigationTracker.track(pageName: pageName, url: url)
        if formName != nil {
            formInteractionTracker.track(formName: formName!, view: view, pageviewId: navigationTracker.pageTrack!.pageviewId)
        }
    }
    
    public func stopTrack() {
        formInteractionTracker.stopTrack()
    }
    
    public func submit() {
        formInteractionTracker.sendForm()
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension CrossClassify {
    static let baseUrl: String = "https://api.crossclassify.com/collect"
    static let logger: DefaultLogger = DefaultLogger(minLevel: .warning)
}
