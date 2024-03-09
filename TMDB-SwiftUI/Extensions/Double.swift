//
//  Double.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//

import Foundation

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
    
        func string(maximumFractionDigits: Int = 2) -> String {
            let s = String(format: "%.\(maximumFractionDigits)f", self)
            for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
                if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                    return String(s[..<s.index(s.endIndex, offsetBy: i)])
                }
            }
            return String(s[..<s.index(s.endIndex, offsetBy: -maximumFractionDigits - 1)])
        }
}
