import Foundation
import SwiftUI

class CalcState: ObservableObject{
 
    var output = "0" {willSet{
        objectWillChange.send()
    }}
    
//    init(output: String = "") {
//        self.output = output
//    }
//    var buttonHeight: Double = 0 {willSet{
//        objectWillChange.send()
//    }}
// 
//    func getButtonSize()-> Double{
//        return ((UIScreen.main.bounds.width - 60) / 4)
//    }
}
