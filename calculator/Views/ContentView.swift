import SwiftUI
import Combine


struct ContentView: View {
    // AC turns to C when output in not zero
    // максимум 9 разрядов
    // при делении на 0 выдаёт error
    // при переполнении экспоненциальная запись
    // чёрный текст на светло-серых кнопках
    @EnvironmentObject var state: CalcState
    
    var body: some View {
        ZStack{
            Color.eerieBlack.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                OutputView()
                    .padding()
                GridView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CalcState())
    }
}

