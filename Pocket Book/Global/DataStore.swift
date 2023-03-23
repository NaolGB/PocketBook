import Foundation
import FirebaseCore
import FirebaseFirestore



class DataStore: ObservableObject {
    @Published var userUID: String = ""
    @Published var wallet: Wallet?
    
    func setUserUID(userUID: String) {
        self.userUID = userUID
    }
    
    func getUserUID() -> String {
        return self.userUID
    }
    
    func createNewUserDocument(userUID: String) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("wallet")
        collectionRef.document(userUID).setData([
            "current_balance": 0.0,
            "expenses": []
        ])
        
    }
    
    func fetchWallet() {
        let db = Firestore.firestore()
        let docRef = db.collection("wallet").document(userUID)
        docRef.getDocument { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                let data = document?.data()
                let currentBalance: Float = (data!["current_balance"] as? Float)!
                var expenses: [Wallet.Expense] = []
                
                //                parse expenses
//                for expense in (data!["expenses"] as? [Wallet.Expense])! {
//                    let newExpense: Wallet.Expense = Wallet.Expense(amount: expense.amount, date: expense.date, type: expense.type)
//                    expenses.append(newExpense)
//                }
                
                for expense in data!["expense"] as! [Any] {
                    var amount = expense["amount"]
                    var date = expense["date"]
                    var type = expense["type"]
                }
                print(data)
                
                let newWallet: Wallet = Wallet(id: self.userUID, currentBalance: currentBalance, expenses: expenses)
                self.wallet = newWallet
            }
        }
    }
    
    func updateBalance() {
        let db = Firestore.firestore()
        let docRef = db.collection("wallet").document(userUID)
        docRef.updateData([
            "current_balance": wallet!.currentBalance
        ]) {    err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
    }
    
    func updateExpense(newExpense: Wallet.Expense) {
        let db = Firestore.firestore()
        let docRef = db.collection("wallet").document(userUID)
        docRef.updateData([
            "expenses": FieldValue.arrayUnion([
                ["amount": newExpense.amount, "date": newExpense.date, "type": newExpense.type.rawValue]
            ])
        ]) {    err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
    }
}
