
import Foundation
import SwiftUI
import Combine


public struct TrackedStepper: TrackedField, View {
    
    var value: Binding<Int>? = nil
    var bounds: ClosedRange<Int>? = nil
    var step: Int.Stride? = nil
    var titleKey: LocalizedStringKey? = nil
    
    var id: String?
    var trackContent: Bool
    var cc: CrossClassify
    
    @State var metadata = Metadata()
    
    public init(_ titleKey: LocalizedStringKey, value: Binding<Int>, in bounds: ClosedRange<Int>, step: Int.Stride? = 1, id: String, trackContent: Bool, cc: CrossClassify) {
        self.titleKey = titleKey
        self.value = value
        self.bounds = bounds
        self.step = step
        
        self.trackContent = trackContent
        self.id = id
        self.cc = cc
    }

    public var body: some View {
        
        return Stepper(
            titleKey!,
            value: value!.onChange({_ in metadata.editingChanged()}), in: bounds!, step: step!
        )
        .onAppear(perform: {Util.updateField(cc: cc, field: self)})
    }
    
    var content: String {get {return String(value!.wrappedValue) ?? ""}} //TODO: do convert V to String
    var fieldType: String? {get { return "stepper" }}
    
    var timeSpentEditing: TimeInterval? = nil
}
