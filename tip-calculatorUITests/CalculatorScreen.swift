//
//  CalculatorScreen.swift
//  tip-calculatorUITests
//
//  Created by Yasha Serhiienko on 29.06.2023.
//

import XCTest

class CalculatorScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: Elements
    
    var logoView: XCUIElement {
        return app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    var billInputViewTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    var tenPercentTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    
    var fifteenPercentTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    
    var twentyPercentTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    
    var customTipAlertTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    var incrementButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    
    var decrementButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    
    var quantityValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    // MARK: Actions
    
    func enterBill(amount: Double) {
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n")
    }
    
    func selectTip(tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentTipButton.tap()
        case .fifteenPercent:
            fifteenPercentTipButton.tap()
        case .twentyPercent:
            twentyPercentTipButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }

    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }

    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
        
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
    
}
