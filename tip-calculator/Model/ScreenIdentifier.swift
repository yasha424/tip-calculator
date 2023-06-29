//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by Yasha Serhiienko on 29.06.2023.
//

import Foundation

enum ScreenIdentifier {
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum LogoView: String {
        case logoView
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
    
}
