import Foundation

class DataStore: ObservableObject {
    @Published private var userUID: String = ""
    
    func setUserUID(userUID: String) {
        self.userUID = userUID
    }
    
    func getUserUID() -> String {
        return self.userUID
    }
}
