//
//  OutputView.swift
//  calculator
//
//  Created by Danil Vasilenko on 14.03.2023.
//

import SwiftUI

struct OutputView: View {
    @EnvironmentObject var state: CalcState
    var body: some View {
            HStack{
                Spacer()
                Text(state.output)
                    .font(.system(size: 110))
                    .foregroundColor(.white) 
        }
    }
    
struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView()
    }
}}
