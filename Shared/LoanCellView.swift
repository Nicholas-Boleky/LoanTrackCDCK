//
//  LoanCellView.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/26/21.
//

import SwiftUI

struct LoanCellView: View {

    let name: String
    let amount: Double
    let date: Date

    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(amount.toCurrency)
                    .font(.title2)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Text(date.longDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}

struct LoanCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoanCellView(name: "Test Name", amount: 10000, date: Date())
    }
}
