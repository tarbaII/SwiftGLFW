public enum ButtonState: Int32 {
    case released, pressed
    init(_ rawValue: Int32) {
        switch rawValue {
            case 1, 2: self = .pressed
            default: self = .released
        }
    }
}
