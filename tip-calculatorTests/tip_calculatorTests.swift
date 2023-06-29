//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Yasha Serhiienko on 21.06.2023.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {

    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        sut = .init(audioPlayerService: audioPlayerService)
        cancellables = .init()
        logoViewTapSubject = .init()
        audioPlayerService = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
        logoViewTapSubject = nil
        audioPlayerService = nil
    }
    
    func testResultWithoutTipFor1Person() {
        let bill = 100.0
        let tip = Tip.none
        let split = 1
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWithoutTipFor2Person() {
        let bill = 150.0
        let tip = Tip.none
        let split = 2
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 75)
            XCTAssertEqual(result.totalBill, 150)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        let bill = 200.0
        let tip = Tip.tenPercent
        let split = 2
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 110.0)
            XCTAssertEqual(result.totalBill, 220.0)
            XCTAssertEqual(result.totalTip, 20.0)
        }.store(in: &cancellables)
    }

    func testResultWithCustomTipFor4Person() {
        let bill = 200.0
        let tip = Tip.custom(value: 60)
        let split = 4
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 65.0)
            XCTAssertEqual(result.totalBill, 260.0)
            XCTAssertEqual(result.totalTip, 60.0)
        }.store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorResetOnLogoViewTap() {
        let input = buildInput(bill: 1, tip: .none, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectation
        
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)
        
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }

    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }

}

class MockAudioPlayerService: AudioPlayerService {
    var expectation = XCTestExpectation(description: "playSound is called")
    
    func playSound() {
        expectation.fulfill()
    }
}
