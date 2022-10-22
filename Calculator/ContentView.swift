//
//  ContentView.swift
//  Calculator
//
//  Created by geonhui Yu on 2022/10/15.
//

import SwiftUI

enum ButtonType: Hashable {
    
    case number(String)
    case calculation(String)
    case unit(String)
    
    var buttonDisplayName: String {
        
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
        case .number, .calculation:
            return .white
        case .unit:
            return .black
        }
    }
}

struct ContentView: View {
    
    @State fileprivate var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var isFirstInput: Bool = true
    
    @State var operateType: ButtonType = .unit("C")
    
    private let buttonData: [[ButtonType]] = [
        [.unit("C"), .unit("+/-"), .unit("%"), .calculation("/")],
        [.number("7"), .number("8"), .number("9"), .calculation("*")],
        [.number("4"), .number("5"), .number("6"), .calculation("-")],
        [.number("1"), .number("2"), .number("3"), .calculation("+")],
        [.number("0"), .number(","), .calculation("=")],
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
                        
                        ForEach(line, id: \.self) { item in
                            
                            Button {
                                
                                self.calculate(type: item)
                                
                            } label: {
                                
                                Text(item.buttonDisplayName)
                                    .bold()
                                    .frame(width: calculateButtonWidth(item), height: calculateButtonHeight(item))
                                    .background(item.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(item.forgroundColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }
                }
            }
        }
    }
}

private func calculateButtonWidth(_ type: ButtonType) -> CGFloat {
    
    switch type {
    case .number("0"):
        return (UIScreen.main.bounds.width - 5 * 10) / 4 * 2
        
    default: return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
}

private func calculateButtonHeight(_ type: ButtonType) -> CGFloat {
    
    return (UIScreen.main.bounds.width - 5 * 10) / 4
}

extension ContentView {
    
    private func calculate(type: ButtonType) {
        
        if isFirstInput {
            
            switch type {
                
            case .unit("C"): return totalNumber = "0"
            case .number:
                totalNumber += type.buttonDisplayName
                self.isFirstInput = false
                return
            case .calculation: return self.isFirstInput = false
            case .unit: return self.isFirstInput = false
            }
        }
        
        else {
                     
            switch type {
            case .unit("C"): return totalNumber = "0"
            case .number:
                totalNumber = ""
                totalNumber += type.buttonDisplayName
                return
                
            case .calculation("+"), .calculation("-"), .calculation("*"), .calculation("/"): do {
                
                tempNumber = Int(totalNumber) ?? 0
                self.operateType = type
            }
                
            case .calculation("="): do {
    
                switch self.operateType {
                case .calculation("+"): return totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                    
                case .calculation("-"): return totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                    
                case .calculation("*"): return totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                    
                case .calculation("/"): return totalNumber = String((Int(totalNumber) ?? 0) / tempNumber)
                default: return
                }
            }
                
            default: return
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
