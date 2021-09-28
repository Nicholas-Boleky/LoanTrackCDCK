//
//  AddLoanView.swift
//  LoanTrackCDCK
//
//  Created by Nicholas Boleky on 9/28/21.
//

import SwiftUI

struct AddLoanView: View {
    
    @State var name = ""
    @State var ammount = ""
    @State var startDate = Date()
    @State var dueDate = Date()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 30)
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 30)
                }
            }//end of HStack
            .padding()
            
            Form {
                TextField("Name", text: $name)
                TextField("Amount", text: $ammount)
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
        }
    }
}

struct AddLoanView_Previews: PreviewProvider {
    static var previews: some View {
        AddLoanView()
    }
}
