//
//  tip_calculatorSnapshotTests.swift
//  tip-calculatorTests
//
//  Created by Yasha Serhiienko on 29.06.2023.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_calculatorSnapshotTest: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        let size = CGSize(width: screenWidth, height: 48)
        let view = LogoView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInititalResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        let size = CGSize(width: screenWidth, height: 56+56+16)
        let view = TipInputView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }

    func testInitialBillInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = TipInputView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitInputView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }

}
