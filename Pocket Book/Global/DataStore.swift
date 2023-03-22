import Foundation
import FirebaseCore
import FirebaseFirestore



class DataStore: ObservableObject {
    @Published private var userUID: String = ""
    
    func createNewUserDocument(userUID: String) {
        let db = Firestore.firestore()
        let wallet = db.collection("walet")
        
        wallet.document(userUID).setData([
            "current_balance": 0.0,
            "expenses": [],
        ])
        
    }
    
    func setUserUID(userUID: String) {
        self.userUID = userUID
    }
    
    func getUserUID() -> String {
        return self.userUID
    }
}
