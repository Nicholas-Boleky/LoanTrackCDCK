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
    @Published var payment: Payment?
    
    //Not published because it will not be changing
    var loanId: String
    
    init(paymentToEdit payment: Payment?, loanId: String) {
        self.payment = payment
        self.loanId = loanId
    }
    
    //Logic to decide if updating or create new Payment
    func savePayment() {
        if payment != nil {
            updatePayment()
        } else {
            createNewPayment()
        }
    }
    
    func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loanid = loanId
        
        PersistenceController.shared.save()
    }
    
    func updatePayment() {
        //checks for nil in savePayment so force unwrap is safe
        payment!.amount = Double(amount) ?? 0.0
        payment!.date = date
        
        PersistenceController.shared.save()
    }
    
    func setupEditingView() {
        if payment != nil {
            //force unwrapping okay because above checks if nil
            amount = "\(payment!.amount)"
            date = payment!.date ?? Date()
        }
    }
    
    //returns false if they havent entered an ammount. Used to disable save button until they enter payment ammount
    func isFormValid() -> Bool {
        return amount.isEmpty
    }
    
}
