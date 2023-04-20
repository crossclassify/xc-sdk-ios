import Foundation
import CoreGraphics

/// Represents an event of any kind.
///
/// # Key Mapping:
/// Most properties represent a key defined at: [Tracking HTTP API](https://developer.piwik.org/api-reference/tracking-api). Keys that are not supported for now are:
///
/// - idsite, rec, rand, apiv, res, cookie,
/// - All Plugins: fla, java, dir, qt, realp, pdf, wma, gears, ag
public struct Event: Codable {
    public let uuid: UUID
    let siteId: String
    let visitor: Visitor
    let session: Session
    
    /// This flag defines if this event is a so called cutom action.
    /// api-key: ca
    /// More info: https://github.com/matomo-org/matomo-sdk-ios/issues/354
    /// and https://github.com/matomo-org/matomo-sdk-ios/issues/363
    let isCustomAction: Bool
    
    /// The Date and Time the event occurred.
    /// api-key: h, m, s
    let date: Date
    
    /// The full URL for the current action. 
    /// api-key: url
    let url: URL?
    
    /// api-key: action_name
    let actionName: [String]
    
    /// The language of the device.
    /// Should be in the format of the Accept-Language HTTP header field.
    /// api-key: lang
    let language: String
    
    /// Should be set to true for the first event of a session.
    /// api-key: new_visit
    let isNewSession: Bool
    
    /// Currently only used for Campaigns
    /// api-key: urlref
    let referer: URL?
    var screenResolution: CGSize = Device.makeCurrentDevice().screenSize
    
    /// api-key: _cvar
    let customVariables: [CustomVariable]
    
    /// Event tracking
    /// https://piwik.org/docs/event-tracking/
    let eventCategory: String?
    let eventAction: String?
    let eventName: String?
    let eventValue: Float?
    
    let fa_fields: [FormField]
    let fa_vid: String?
    let pv_id: String?
    let fa_name: String?
    let fa_id: String?
    let fa_su: Int?
    
    let fa_ef: String?  ///first interacted field
    let fa_lf: String?  ///last interacted field
    let fa_ts: Int?  ///total time spent
    let fa_ht: Int?  ///hesitation time
    let fa_st: Int?     ///form first view
    let fa_tts: Int? ///time to first submit
    
    /// Campaign tracking
    /// https://matomo.org/docs/tracking-campaigns/
    let campaignName: String?
    let campaignKeyword: String?

    /// Search tracking
    /// api-keys: search, search_cat, search_count
    let searchQuery: String?
    let searchCategory: String?
    let searchResultsCount: Int?
    
    let dimensions: [CustomDimension]
    
    let customTrackingParameters: [String:String]
    
    /// Content tracking
    /// https://matomo.org/docs/content-tracking/
    let contentName: String?
    let contentPiece: String?
    let contentTarget: String?
    let contentInteraction: String?
    
    /// Goal tracking
    /// https://matomo.org/docs/tracking-goals-web-analytics/
    let goalId: Int?
    let revenue: Float?

    /// Ecommerce Order tracking
    /// https://matomo.org/docs/ecommerce-analytics/#tracking-ecommerce-orders-items-purchased-required
    let orderId: String?
    let orderItems: [OrderItem]
    let orderRevenue: Float?
    let orderSubTotal: Float?
    let orderTax: Float?
    let orderShippingCost: Float?
    let orderDiscount: Float?
    let orderLastDate: Date?
}

extension Event {
    public init(tracker: MatomoTracker, action: [String], url: URL? = nil, referer: URL? = nil, eventCategory: String? = nil, eventAction: String? = nil, eventName: String? = nil, eventValue: Float? = nil, customTrackingParameters: [String:String] = [:], searchQuery: String? = nil, searchCategory: String? = nil, searchResultsCount: Int? = nil, dimensions: [CustomDimension] = [], variables: [CustomVariable] = [], contentName: String? = nil, contentInteraction: String? = nil, contentPiece: String? = nil, contentTarget: String? = nil, goalId: Int? = nil, revenue: Float? = nil, orderId: String? = nil, orderItems: [OrderItem] = [], orderRevenue: Float? = nil, orderSubTotal: Float? = nil, orderTax: Float? = nil, orderShippingCost: Float? = nil, orderDiscount: Float? = nil, orderLastDate: Date? = nil, isCustomAction: Bool, fa_fields: [FormField] = [], fa_vid: String? = nil, pv_id: String? = nil, fa_name: String? = nil, fa_id: String? = nil, fa_su: Int? = nil, fa_ef: String? = nil, fa_lf: String? = nil, fa_ts: Int? = nil, fa_ht: Int? = nil, fa_st: Int? = nil, fa_tts: Int? = nil) {
        
        
        self.siteId = tracker.siteId
        self.uuid = UUID()
        self.visitor = tracker.visitor
        self.session = tracker.session
        self.date = Date()
        self.url = url ?? tracker.contentBase?.appendingPathComponent(action.joined(separator: "/"))
        self.actionName = action
        self.language = Locale.httpAcceptLanguage
        self.isNewSession = tracker.nextEventStartsANewSession
        self.referer = referer
        
        self.eventCategory = eventCategory
        self.eventAction = eventAction
        self.eventName = eventName
        self.eventValue = eventValue
        
        self.fa_fields = fa_fields
        self.fa_vid = fa_vid
        self.pv_id = pv_id
        self.fa_name = fa_name
        self.fa_id = fa_id
        self.fa_su = fa_su
        
        self.fa_ef = fa_ef
        self.fa_lf = fa_lf
        self.fa_ts = fa_ts
        self.fa_ht = fa_ht
        self.fa_st = fa_st
        self.fa_tts = fa_tts
        
        self.searchQuery = searchQuery
        self.searchCategory = searchCategory
        self.searchResultsCount = searchResultsCount
        self.dimensions = tracker.dimensions + dimensions
        self.campaignName = tracker.campaignName
        self.campaignKeyword = tracker.campaignKeyword
        self.customTrackingParameters = customTrackingParameters
        self.customVariables = tracker.customVariables + variables
        self.contentName = contentName
        self.contentPiece = contentPiece
        self.contentTarget = contentTarget
        self.contentInteraction = contentInteraction
        self.goalId = goalId
        self.revenue = revenue
        self.orderId = orderId
        self.orderItems = orderItems
        self.orderRevenue = orderRevenue
        self.orderSubTotal = orderSubTotal
        self.orderTax = orderTax
        self.orderShippingCost = orderShippingCost
        self.orderDiscount = orderDiscount
        self.orderLastDate = orderLastDate
        self.isCustomAction = isCustomAction
    }
}


public struct FormField: Codable {
    public init(fa_fn: String, fa_cn: String? = nil, fa_fts: Int? = nil, fa_fht: Int? = nil, fa_fb: Bool? = nil, fa_fch: Int? = nil, fa_ff: Int? = nil, fa_fd: Int? = nil, fa_cu: Int? = nil, fa_ft: String? = nil, fa_fs: Int? = nil) {
        self.fa_fn = fa_fn
        self.fa_cn = fa_cn
        self.fa_fts = fa_fts
        self.fa_fht = fa_fht
        self.fa_fb = fa_fb
        self.fa_fch = fa_fch
        self.fa_ff = fa_ff
        self.fa_fd = fa_fd
        self.fa_cu = fa_cu
        self.fa_ft = fa_ft
        self.fa_fs = fa_fs
    }
    
    
    
    let fa_fn: String
    var fa_cn: String? = nil
    
    var fa_fts: Int? = nil   ///total time spent
    var fa_fht: Int? = nil   ///hesitation time
    var fa_fb: Bool? = nil      ///left blank
    var fa_fch: Int? = nil      ///number of changes
    var fa_ff: Int? = nil       ///number of focus
    var fa_fd: Int? = nil       ///number of deletes
    var fa_cu: Int? = nil       ///number of cursor
    var fa_ft: String? = nil    ///type
    var fa_fs: Int? = nil       ///size
}
