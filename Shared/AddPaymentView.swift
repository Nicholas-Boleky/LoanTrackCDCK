//
//  AddPaymentView.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/29/21.
//

import SwiftUI

struct AddPaymentView: View {
    
    @ObservedObject var viewModel: AddPaymentViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        
        Form {
            Section {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
            }
            
            Section {
                Button {
                    viewModel.savePayment()
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .disabled(viewModel.isFormValid())
            
        }//form end
        .onAppear() {
            viewModel.setupEditingView()
        }
        .navigationTitle(viewModel.payment != nil ? "Edit Payment" : "Add Payment")
    }
}

//struct AddPaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPaymentView()
//    }
//}
