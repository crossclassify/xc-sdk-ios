import Foundation
import UIKit

class TrackedUIPickerView: UIPickerView, TrackedField {
    
    @IBInspectable var id: String?
    @IBInspectable var includeContent: Bool = false
    
    var metadata = Metadata()
//    var metadata = Metadata(trackFocus: true)

    override func awakeFromNib() {
        super.awakeFromNib()
        if value(forKey: "id") == nil {
            fatalError("TrackedField's \"id\" must be provided")
        }
    }

    var content: String {get {return String(selectedRow(inComponent: 0))}}
    var trackContent: Bool {get { return includeContent }}
    var fieldType: String? {get { return "select" }}
}
