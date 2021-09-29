//
//  AddLoanView.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/28/21.
//

import SwiftUI

struct AddLoanView: View {
    
    //Because initializing viewmodel for the first time I must use StateObject. Because its initialized here I may need to pass it to another file and will use @ObservedObject (do not initalize ObservedObject)
    @ObservedObject var viewModel: AddLoanViewModel
//    @State var name = ""
//    @State var ammount = ""
//    @State var startDate = Date()
//    @State var dueDate = Date()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    viewModel.isAddLoanShowing.wrappedValue = false
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 30)
                }
                Spacer()
                
                Button {
                    viewModel.saveLoan()
                    viewModel.isAddLoanShowing.wrappedValue = false
                } label: {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 30)
                }
                .disabled(viewModel.isValidForm())
            }//end of HStack
            .padding()
            
            Form {
                TextField("Name", text: $viewModel.name)
                    .autocapitalization(.sentences)
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                DatePicker("Due Date", selection: $viewModel.dueDate, displayedComponents: .date)
            }
        }
    }
}

//struct AddLoanView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLoanView()
//    }
//}
