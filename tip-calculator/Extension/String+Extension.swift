//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Yasha Serhiienko on 29.06.2023.
//

import UIKit

extension String {
    var doubleValue: Double? {
        Double(self.replacingOccurrences(of: ",", with: "."))
    }
}
