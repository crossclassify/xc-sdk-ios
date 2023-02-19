
import Foundation
import SwiftUI
import Combine


public struct TrackedSlider: TrackedField, View {
    
    var value: Binding<Double>? = nil
    var bounds: ClosedRange<Double>? = nil
    var step: Double.Stride? = nil
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
    @State var metadata = Metadata(trackFocus: true)
    
    public init(value: Binding<Double>, in bounds: ClosedRange<Double>, step: Double.Stride? = 1, id: String, trackContent: Bool, cc: CrossClassify) {
        self.value = value
        self.bounds = bounds
        self.step = step
        
        self.trackContent = trackContent
        self.id = id
        self.cc = cc
    }

    public var body: some View {
        
        return Slider(
            value: value!.onChange({_ in metadata.editingChanged()}),
            in: bounds!, step: step!,
            onEditingChanged: { changed in if changed { metadata.editingDidBegin() } else { metadata.editingDidEnd() }}
        )
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
    }
    
   var content: String {get {return String(value!.wrappedValue) ?? ""}} //TODO: do convert V to String
   var fieldType: String? {get { return "slider" }}
}
