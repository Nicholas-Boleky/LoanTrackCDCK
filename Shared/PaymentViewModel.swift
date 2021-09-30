//
//  PaymentViewModel.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/29/21.
//

import Foundation

final class PaymentViewModel: ObservableObject {
    
    //Published to alert PaymentView whenever there is a change in payments
    @Published var allPayments:[Payment] = []
    @Published var allPaymentObjects: [PaymentObject] = []
    @Published var isNavigationLinkActive = false
    @Published var expectedToFinishOn: String = ""
    @Published var selectedPayment: Payment? 
    
    var loan: Loan
    
    init (loan: Loan) {
        self.loan = loan
    }
    
    func totalPaid() -> Double {
        //goes through the allPayments array at each index and adds the amount of the next index to the cumulative total of the previous amoount
        return allPayments.reduce(0) { $0 + $1.amount}
    }
    
    func totalLeft() -> Double {
        return self.loan.totalAmount - totalPaid()
    }
    
    func progressValue() -> Double {
        return totalPaid() / self.loan.totalAmount
    }
    
    
    func fetchAllPayments() {
        allPayments = PersistenceController.shared.fetchPayments(for: loan.id ?? "")
    }
    
    func delete(paymentObject: PaymentObject, index: IndexSet) {
        guard let indexRow = index.first else { return }
        
        let paymentToDelete = paymentObject.sectionObjects[indexRow]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        fetchAllPayments()
        calculateDays()
        separateByYear()
    }
    
    func calculateDays() {
    
        let totalPaid = totalPaid()
        

        
        let passedDays = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: Date()).day!
    
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        
        let didPayPerDay = totalPaid / Double(passedDays)
        
        let daysLeftToFinish = (loan.totalAmount - totalPaid) / didPayPerDay
        
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }
        expectedToFinishOn = "Expected to finish by \(newDate.longDate)"
        
    }
    
    func separateByYear() {
        allPaymentObjects = []
        
        let dict = Dictionary(grouping: allPayments, by: { $0.date?.dayNumberOfYear})
        
        for (key, value) in dict {
            
            var total = 0.0
            
            for payment in value  {
                total += payment.amount
            }
            
            allPaymentObjects.append(PaymentObject(sectionName: "\(key!)", sectionObjects: value, sectionTotal: total))
        }
        
        allPaymentObjects.sorted(by: { $0.sectionName > $1.sectionName } )
    }
    
}

struct PaymentObject: Equatable {
    var sectionName: String!
    var sectionObjects: [Payment]!
    var sectionTotal: Double!
}
