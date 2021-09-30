//
//  AddPaymentViewModel.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/29/21.
//

import Foundation

final class AddPaymentViewModel: ObservableObject {
    
    @Published var amount = ""
    @Published var date = Date()
    
    //Not published because it will not be changing
    var loanId: String
    
    init(loanId: String) {
        self.loanId = loanId
    }
    
    func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loanid = loanId
        
        PersistenceController.shared.save()
    }
    
    
    //returns false if they havent entered an ammount. Used to disable save button until they enter payment ammount
    func isFormValid() -> Bool {
        return amount.isEmpty
    }
    
}
