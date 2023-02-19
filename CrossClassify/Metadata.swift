import Foundation


struct Metadata {
    
    var _trackFocus: Bool
    var _trackDelete: Bool
    
    // filled if _trackFocus == true
    var _isEditing: Bool = false
    var _timeSpentEditing: Double = 0
    var _latestEditingStartedAt: Double? = nil
    var _firstEditingStartedAt: Double? = nil
    var _isChangedSinceLastEditing: Bool = false
    
    // filled if _trackDelete == true
    var _textLen: Int = 0
    
    var timeSpentBeforeEditing: Double? = nil
    var firstChangeAt: Double? = nil
    var latestChangeAt: Double? = nil
    var numChanges: Int? = 0
    var numFocus: Int? = nil
    var numDeletes: Int? = nil
    var numCursor: Int? = nil
    var timeSpentEditing: TimeInterval? {
        get {
            if !_trackFocus { return nil }
            let currentTimestamp = NSDate().timeIntervalSince1970
            if _isEditing {
                return Double(_timeSpentEditing + (currentTimestamp - _latestEditingStartedAt!))
            } else {
                return Double(_timeSpentEditing)
            }
        }
    }
    
    internal init(trackFocus: Bool = false, trackDelete: Bool = false) {
        _trackFocus = trackFocus
        _trackDelete = trackDelete
        if _trackFocus { numFocus = 0 }
        if _trackDelete { numDeletes = 0 }
    }
    
    mutating func editingDidBegin() {
        if _isEditing {
            return
        }
        _isEditing = true
        let currentTimestamp = NSDate().timeIntervalSince1970
        numFocus = numFocus! + 1
        _latestEditingStartedAt = currentTimestamp
        if _firstEditingStartedAt == nil {
            _firstEditingStartedAt = currentTimestamp
        }
        _isChangedSinceLastEditing = false
    }
    
    mutating func editingDidEnd() {
        if !_isEditing {
            return
        }
        _isEditing = false
        let currentTimestamp = NSDate().timeIntervalSince1970
        _timeSpentEditing += currentTimestamp - _latestEditingStartedAt!
    }
    
    mutating func editingChanged(newTextLen: Int? = nil) {
        if !_isEditing && _trackFocus {
            return
        }
        let currentTimestamp = NSDate().timeIntervalSince1970
        if timeSpentBeforeEditing == nil && _latestEditingStartedAt != nil {
            timeSpentBeforeEditing =  _timeSpentEditing + (currentTimestamp - _latestEditingStartedAt!)
        }
        if !_isChangedSinceLastEditing || !_trackFocus {
            if numChanges == 0 {
                firstChangeAt = currentTimestamp
            }
            numChanges = numChanges! + 1
            latestChangeAt = currentTimestamp
            _isChangedSinceLastEditing = true
        }
        if newTextLen != nil {
            numDeletes = numDeletes! + max(_textLen - newTextLen!, 0)
            _textLen = newTextLen!
        }
    }
}
