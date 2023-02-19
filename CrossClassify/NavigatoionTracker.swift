import Foundation
import UIKit
import SwiftUI

public class NavigationTracker {
    
    var matomoTracker: MatomoTracker
    var pageTrack: PageTrack?
    
    internal init(_ matomoTracker: MatomoTracker) {
        self.matomoTracker = matomoTracker
    }
    
    internal func track(pageName: String, url: URL?){
        pageTrack = PageTrack(pageName: pageName, url: url)
        matomoTracker.trackPage(view: [pageName],
                                url: url,
                                dimensions: [],
                                pv_id: pageTrack?.pageviewId)
        matomoTracker.dispatch()
    }
}

//extension View {
//    func trackView(pageName: [String]) -> some View {
//        return self.onAppear { MatomoTracker.shared.track(view: view) }
//    }
//}

//extension View {
//    func track(view: [String]) -> any View {
//        MatomoTracker.shared.track(view: view)
//        return self
//    }
//}
