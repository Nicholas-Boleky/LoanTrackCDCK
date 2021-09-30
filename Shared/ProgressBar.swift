//
//  ProgressBar.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/29/21.
//

import SwiftUI

struct ProgressBar: View {
    
    var value: Double
    var leftAmount: Double
    var paidAmount: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Text(leftAmount.toCurrency)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                    
                    Text(paidAmount.toCurrency)
                        .font(.caption)
                        
                        .padding(.horizontal)
                }
                
            }//end zstack
            .cornerRadius(45)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.3, leftAmount: 1000, paidAmount: 300)
    }
}
