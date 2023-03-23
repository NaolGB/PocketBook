import SwiftUI

struct Home: View {
    @EnvironmentObject var dataStore: DataStore
    @State var depositSheetOpen: Bool = false
    @State var expenseSheetOpen: Bool = false
    @State var amount: String = ""
    @State var date: Date = Date()
    @State var expenseType: Wallet.ExpenseType = .others
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Here is your PocketBook")
                    .font(.title)
                Text("Current balance: \(dataStore.wallet?.currentBalance ?? 0.0)")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Deposit") {
                        depositSheetOpen.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add expense") {
                        expenseSheetOpen.toggle()
                    }
                }
            }
            .sheet(isPresented: $depositSheetOpen) {
                TextField("amount", text: $amount, prompt: Text("0.0"))
                    .textFieldStyle(.roundedBorder)
                Button("Deposit $\(amount)") {
                    dataStore.wallet?.currentBalance += Float(amount) ?? 0.0
                    dataStore.updateBalance()
                    amount = ""
                    depositSheetOpen = false
                }
                .buttonStyle(.borderedProminent)
            }
            .sheet(isPresented: $expenseSheetOpen) {
                TextField("amount", text: $amount, prompt: Text("0.0"))
                DatePicker("date", selection: $date)
                Picker("Expense type", selection: $expenseType) {
                    ForEach(Wallet.ExpenseType.allCases) { expType in
                        Text(expType.rawValue)
                    }
                }
                Button("Spend \(amount) on \(expenseType.rawValue)") {
                    let newExpense: Wallet.Expense = Wallet.Expense(amount: Float(amount) ?? 0.0, date: date, type: expenseType)
                    dataStore.wallet?.currentBalance -= Float(amount) ?? 0.0
                    dataStore.wallet?.expenses.append(newExpense)
                    dataStore.updateBalance()
                    dataStore.updateExpense(newExpense: newExpense)
                    amount = ""
                    expenseSheetOpen = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
