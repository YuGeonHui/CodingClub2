//
//  ContentView.swift
//  Calculator
//
//  Created by geonhui Yu on 2022/10/15.
//

import SwiftUI

enum ButtonType: Hashable {
    
    case number(String?)
    case calculation(String?)
    case unit(String?)
    
    var buttonDisplayName: String? {
        
        switch self {
        case .number(let number):
            return number
            
        case .calculation(let calculate):
            return calculate
            
        case .unit(let unit):
            return unit
        }
    }
    
    var backgroundColor: Color {
        
        switch self {
        case .number:
            return .gray
        case .calculation:
            return .orange
        case .unit:
            return .yellow
        }
    }
    
    var forgroundColor: Color {
        
        switch self {
        case .number:
            return .white
        case .calculation, .unit:
            return .black
        }
    }
}

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    
    private let buttonData: [[ButtonType]] = [
        [.unit("C"), .unit("/"), .unit("%"), .calculation("=")],
        [.number("7"), .number("8"), .number("9"), .calculation("X")],
        [.number("4"), .number("5"), .number("6"), .calculation("-")],
        [.number("1"), .number("2"), .number("3"), .calculation("+")],
        [.number("0"), .number("0"), .number(","), .calculation("=")],
    ]
    
    var body: some View {
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            
            VStack {
            
                Spacer()
                
                HStack {
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData, id: \.self) { line in
                    
                    HStack {
                        
                        ForEach(line, id: \.self) { row in
                            
                            Button {
                                
                                totalNumber += row.buttonDisplayName ?? ""
                                
                            } label: {
                                Text(row.buttonDisplayName ?? "")
                                    .frame(width: 80, height: 80)
                                    .background(row.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(row.forgroundColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
