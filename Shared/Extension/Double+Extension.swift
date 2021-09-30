//
//  Double+Extension.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/26/21.
//

import Foundation

extension Double {
    var toCurrency: String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.numberStyle = .currency
        
        currencyFormatter.locale = Locale.current
        
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        
        return priceString
    }
}
