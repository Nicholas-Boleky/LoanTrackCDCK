//
//  LoansView.swift
//  Shared
//
//  Created by Nicholas Boleky on 9/24/21.
//

import SwiftUI
import CoreData

struct LoansView: View {
    @Environment(\.managedObjectContext) private var viewContext

    //This is only one way to load item from CoreData
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    private var loans: FetchedResults<Loan>
    
    @State var isAddLoanShowing = false

    var body: some View {
        NavigationView {
            List {
                //Navigation Link taking in destination and label which will be a view that will be presented (label is the custom cell we made)
                
                ForEach(loans) { loan in
                    NavigationLink(destination: PaymentsView(viewModel: PaymentViewModel(loan: loan))) {
                    LoanCellView(name: loan.name ?? "Unknown", amount: loan.totalAmount, date: loan.dueDate ?? Date())
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("All Loans")
            .navigationBarItems(trailing:
                                    Button {
                isAddLoanShowing = true
            } label: {
            Image(systemName: "plus")
                    .font(.title)
            })
        }
        .accentColor(Color(.label))
        .sheet(isPresented: $isAddLoanShowing) {
            AddLoanView(viewModel: AddLoanViewModel(isAddLoanShowing: $isAddLoanShowing))
        }
    }

    private func addItem() {
        withAnimation {
            let newLoan = Loan(context: viewContext)
            newLoan.name = "Test Loan"
            newLoan.totalAmount = 10000
            newLoan.startDate = Date()
            newLoan.dueDate = Date()

            do {
                try viewContext.save()
            } catch {
                print("Couldnt save to CoreData\(error.localizedDescription)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
