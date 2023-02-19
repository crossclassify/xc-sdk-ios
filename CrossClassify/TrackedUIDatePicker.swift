import Foundation
import UIKit

class TrackedUIDatePicker: UIDatePicker, TrackedField {
    
    @IBInspectable var id: String?
    @IBInspectable var includeContent: String?
    
    var metadata = Metadata(trackFocus: true)

    override func awakeFromNib() {
        super.awakeFromNib()
        if value(forKey: "id") == nil {
            fatalError("TrackedField's \"id\" must be provided")
        }
        
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(editingChanged), for: .valueChanged)
    }
    
    @objc func editingDidBegin() { metadata.editingDidBegin() }
    @objc func editingDidEnd() { metadata.editingDidEnd() }
    @objc func editingChanged() { metadata.editingChanged() }
    
    var content: String {get {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }}
    var trackContent: Bool {get { return includeContent != nil}}
    var fieldType: String? {get { return "date" }}
}
