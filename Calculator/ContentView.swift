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
    
    @State var isEditing: Bool = false
    
    @State var operateType: ButtonType = .unit("C")
    
    private let buttonData: [[ButtonType]] = [
        [.unit("C"), .unit("+/-"), .unit("%"), .calculation("/")],
        [.number("7"), .number("8"), .number("9"), .calculation("X")],
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
                                
                                if item == .unit("C") { totalNumber = "0" }
                                
                                if !isEditing {
                                    
                                    totalNumber += item.buttonDisplayName
                                    (totalNumber, isEditing) = onlyNumberIntput(type: item, inputValue: totalNumber)
                                    
//                                    if item == .unit("C") {
//
//                                        totalNumber = "0"
//
//                                    } else if item == .calculation("+") {
//
//                                        return
//
                                    
//                                    } else {
//                                        totalNumber += item.buttonDisplayName
//                                        isEditing = true
//                                    }
                                    
                                } else {
                                    
                                    if item == .calculation("+") {
                                        
                                        tempNumber = Int(totalNumber) ?? 0
                                        operateType = .unit("+")
                                        totalNumber = "0"
                                        
                                    } else if item == .calculation("=") {
                                        
                                        if operateType == .unit("+") {
                                            totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                                        }
                                        
                                        print("operatyeType2: \(operateType)")
                                        print("unit: \(item)")
                                        
                                    } else {
                                        
                                        totalNumber += item.buttonDisplayName
                                    }
                                    
                                }
                                
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

private func onlyNumberIntput(type: ButtonType, inputValue: String) -> (String ,Bool) {
    
    switch type {
        
    case .number: return (inputValue, true)
    case .calculation: return ("0", false)
    case .unit: return ("0", false)
    }
}

private func calculate(item: ButtonType, tempNumber: Int, totalNumber: Int) {
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
