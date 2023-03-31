import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case addition = "+"
    case subtraction = "–"
    case multiplication = "×"
    case division = "÷"
    case signChange = "±"
    case percent = "%"
    case reset = "C"
    case decimal = "."
    case equals = "="
    case none = "none"
    
    var backgroundColor: Color{
        switch self{
        case .addition, .subtraction, .multiplication, .division, .equals:
            return .vividGamboge
        case .reset, .signChange, .percent:
            return .lightGray
        default:
            return .darkLiver
        }
    }
    var fontColor: Color{
        switch self{
        case .reset, .signChange, .percent:
            return .black
        default:
            return .white
        }
    }

}
