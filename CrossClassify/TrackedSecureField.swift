
import Foundation
import SwiftUI
import Combine

@available(iOS 15.0, *)
public struct TrackedSecureField: TrackedField, View {
    
    
    var text: Binding<String>? = nil
    var titleKey: LocalizedStringKey? = nil
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
    @FocusState private var isFocused: Bool
    @State var metadata = Metadata(trackFocus: true, trackDelete: true)
    
    
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>, id: String, cc: CrossClassify) {
        self.titleKey = titleKey
        self.text = text
        
        self.trackContent = false
        self.id = id
        self.cc = cc
    }

    public var body: some View {
        return SecureField(
            titleKey!,
            text: text!.onChange({ _ in metadata.editingChanged(newTextLen: content.count) })
        )
        .focused($isFocused)
        .onChange(of: isFocused) { changed in if changed { metadata.editingDidBegin() } else { metadata.editingDidEnd() }}
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
    }
    
    var content: String {get {return text?.wrappedValue ?? ""}}
    var fieldType: String? {get { return "password" }}
}
