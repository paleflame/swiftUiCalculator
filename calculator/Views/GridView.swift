import SwiftUI

struct GridView: View {
    @EnvironmentObject var state: CalcState
    
    var buttonHeight: Double = 0
    var fontSize: Double = 0
    var cornerRadius: Double = 0
    @State var leftNum: String = ""
    @State var rightNum: String = ""
    @State var currentOperation: CalcButton = .none
    
    var buttonsGrid: [[CalcButton]] = [
        [.reset, .signChange, .percent, .division],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .subtraction],
        [.one, .two, .three, .addition],
        [.zero, .decimal, .equals]]
    
    init() {
        buttonHeight = getButtonSize()
        fontSize = buttonHeight * 0.5
        cornerRadius = buttonHeight / 2
    }
    
    func getButtonSize()-> Double{
        return ((UIScreen.main.bounds.width - 60) / 4)
    }
    
    func defineButtonWidth(label: String)-> Double{
        switch label{
        case "0":
            return 2 * buttonHeight + 12
        default:
            return buttonHeight
        }
    }
    
    func formatOutputNumber(changeCondition: String,
                            currentValue: String,
                            newValue: String)-> String{
        if currentValue == changeCondition{
            return newValue
        }
        return "\(currentValue)\(newValue)"
        
    }
    
    func makeNumDecimal(num: String)->String{
        if num.contains("."){
            return num
        }
        return "\(num)."
    }
    
    func returnActiveColor(button: CalcButton, buttonPart: String = "")->Color{

        if button == currentOperation{
            if buttonPart == "text"{
                return button.backgroundColor
            }
            return button.fontColor
        }
        else{
            if buttonPart == "text"{
                return button.fontColor
            }
            return button.backgroundColor
        }
    }

    func onButtonClick(button: CalcButton) {
        switch button {
            
        case .addition, .subtraction, .multiplication, .division:
            currentOperation = button
        
        case .reset:
            leftNum = "0"
            rightNum = ""
            state.output = leftNum
            currentOperation = .none
            
        case .equals:
            state.output = makeCalculations(num1: leftNum,
                                            num2: rightNum,
                                            operation: currentOperation)
            currentOperation = .none
            leftNum = state.output
            rightNum = ""
            
        case .decimal:
            if leftNum == "Error"{
                break
            }
            if currentOperation == .none{
                leftNum = makeNumDecimal(num: leftNum)
                state.output = leftNum
                break
            }
            rightNum = makeNumDecimal(num: rightNum)
            state.output = rightNum
            
        case .signChange:
            if leftNum == "Error"{
                break
            }
            if currentOperation == .none{
                let doubleNum = Double(leftNum)!
                leftNum =
                doubleNum == round(doubleNum) ? "\(Int(leftNum)! * -1)" : "\(Double(leftNum)! * -1)"
                state.output = leftNum
                break
            }
            let doubleNum = Double(rightNum)!
            rightNum =
            doubleNum == round(doubleNum) ? "\(Int(rightNum)! * -1)" : "\(Double(rightNum)! * -1)"
            state.output = rightNum
            
        case .percent:
            if leftNum == "Error"{
                break
            }
            if currentOperation == .none{
                leftNum = "\(Double(leftNum)! / 100)"
                state.output = leftNum
                break
            }
            rightNum = "\(Double(rightNum)! / 100)"
            state.output = rightNum
            break
            
        default:
            if leftNum == "Error" && currentOperation == .none{
                break
            }
            let number = button.rawValue
            
            if currentOperation == .none
            {
                leftNum = formatOutputNumber(changeCondition: "0",
                                             currentValue: leftNum,
                                             newValue: number)
                state.output = leftNum
            }
            else
            {
                rightNum = formatOutputNumber(changeCondition: "",
                                             currentValue: rightNum,
                                             newValue: number)
                state.output = rightNum
            }
    }
}
    
    func makeCalculations(num1: String,
                          num2: String,
                          operation: CalcButton)-> String{
        if leftNum == "Error"{
            return leftNum
        }
        if rightNum == "" && operation == .none{
            return leftNum
        }
        let leftNum = Double(num1)!
        let rightNum = Double(num2) == nil ? Double(num1)! : Double(num2)!
        var result: Double = 0.0
        switch operation{
            
        case .addition:
            result = leftNum + rightNum
        
        case .subtraction:
            result = leftNum - rightNum
            
        case .multiplication:
            result = leftNum * rightNum
            
        case .division:
            if rightNum == 0{
                return "Error"
            }
            result = leftNum / rightNum
        default:
            return "none"
        }
        
        if result == round(result){
            return "\(Int(result))"
        }
        
        return "\(round(result * 1000) / 1000)"
    }
    
    var body: some View {
        VStack(spacing: 12){
            
            ForEach(buttonsGrid, id: \.self){ row in
                HStack(spacing: 12){
                    
                    ForEach(row, id: \.self){ button in
                        Button(action: { self.onButtonClick(button: button)}, label: {
                            Text(button.rawValue)
                                .font(.system(size: self.fontSize))
                                .frame(width: defineButtonWidth(label: button.rawValue), height: self.buttonHeight, alignment: .center)
                                .background(returnActiveColor(button: button))
                                .foregroundColor(returnActiveColor(button: button, buttonPart: "text"))
                                .cornerRadius(self.cornerRadius)
                            
                        })
                    }
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
