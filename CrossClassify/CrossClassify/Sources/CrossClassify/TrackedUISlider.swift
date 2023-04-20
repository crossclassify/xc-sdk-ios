import Foundation
import UIKit

class TrackedUISlider: UISlider, TrackedField {
    
    @IBInspectable var id: String?
    @IBInspectable var includeContent: String?
    
    var metadata = Metadata()
    var _lastChange = NSDate().timeIntervalSince1970
//    var metadata = Metadata(trackFocus: true)

    override func awakeFromNib() {
        super.awakeFromNib()
        if value(forKey: "id") == nil {
            fatalError("TrackedField's \"id\" must be provided")
        }
        
//        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
//        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(editingChanged), for: .valueChanged)
    }
    
//    @objc func editingDidBegin() { metadata.editingDidBegin() }
//    @objc func editingDidEnd() { metadata.editingDidEnd() }
    @objc func editingChanged() {
        let currentTimestamp = NSDate().timeIntervalSince1970
        if currentTimestamp > _lastChange + 0.5 {
            metadata.editingChanged()
        }
        _lastChange = currentTimestamp
    }
    
    var content: String {get {return String(value)}}
    var trackContent: Bool {get { return includeContent != nil}}
    var fieldType: String? {get { return "slider" }}
}
