//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Yasha Serhiienko on 29.06.2023.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher
        ).flatMap { [weak self] (bill, tip, split) in
            let totalTip = self?.getTipAmount(bill: bill, tip: tip) ?? 0
            let totalBill = bill + totalTip
            let amountPerPerson = totalBill / Double(split)
            return Just(Result(
                amountPerPerson: amountPerPerson,
                totalBill: totalBill,
                totalTip: totalTip
            ))
        }.eraseToAnyPublisher()
        
        let resetCalculatorPublisher = input.logoViewTapPublisher.handleEvents(
            receiveOutput: { [weak self] in
                self?.audioPlayerService.playSound()
            }
        ).flatMap {
            return Just($0)
        }.eraseToAnyPublisher()
        
        return Output(
            updateViewPublisher: updateViewPublisher,
            resetCalculatorPublisher: resetCalculatorPublisher
        )
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
    
}
