//
//  PaymentsView.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/29/21.
//

import SwiftUI

struct PaymentsView: View {
    
    @ObservedObject var viewModel: PaymentViewModel
    
    
    
    var body: some View {
        
        VStack{
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            ProgressBar(value: viewModel.progressValue(), leftAmount: viewModel.totalLeft(), paidAmount: viewModel.totalPaid())
                .frame(height: 25)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
            
            List {
                ForEach(viewModel.allPaymentObjects, id: \.sectionName) { paymentObject in
                    
                    Section(header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal.toCurrency)")) {
                        
                        ForEach(paymentObject.sectionObjects) { payment in
                            PaymentCellView(amount: payment.amount, date: payment.date ?? Date())
                                .onTapGesture{
                                    viewModel.isNavigationLinkActive = true
                                    viewModel.selectedPayment = payment
                                }
                        }
                        .onDelete { index in
                            viewModel.delete(paymentObject: paymentObject, index: index)
                            
                        }
                    }
                }
                
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle(viewModel.loan.name ?? "Loan")
        .navigationBarItems(trailing:
                                Button {
            viewModel.isNavigationLinkActive = true
        } label: {
            Image(systemName: "plus")
                .font(.title)
        })
        .background(
            NavigationLink(destination: AddPaymentView(viewModel: AddPaymentViewModel(paymentToEdit: viewModel.selectedPayment, loanId: viewModel.loan.id ?? "")), isActive: $viewModel.isNavigationLinkActive) {
                EmptyView()
            }
                .hidden()
        )
        .onAppear() {
            viewModel.selectedPayment = nil
            viewModel.fetchAllPayments()
            viewModel.calculateDays()
            viewModel.separateByYear()
            
        }
        
    }
}

//struct PaymentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentsView(viewModel: <#PaymentViewModel#>)
//    }
//}
