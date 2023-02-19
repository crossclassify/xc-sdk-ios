
import Foundation
import SwiftUI
import Combine

public struct TrackedTextField: TrackedField, View {
    
    var text: Binding<String>? = nil
    var titleKey: LocalizedStringKey? = nil
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
    @State var metadata = Metadata(trackFocus: true, trackDelete: true)
    
    
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>, id: String, trackContent: Bool, cc: CrossClassify) {
        self.titleKey = titleKey
        self.text = text
        
        self.trackContent = trackContent
        self.id = id
        self.cc = cc
    }

    public var body: some View {
        return TextField(
            titleKey!,
            text: text!,
            onEditingChanged: { changed in if changed { metadata.editingDidBegin() } else { metadata.editingDidEnd() } }
        )
        .onReceive(Just(text)) { text in metadata.editingChanged(newTextLen: content.count)}
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
    }
    
    var content: String {get {return text?.wrappedValue ?? ""}}
    var fieldType: String? {get { return "text" }}
}
