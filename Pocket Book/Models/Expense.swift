import Foundation

struct Wallet: Identifiable {
    var id: String
    var currentBalance: Float
    var expenses: [Expense]
    
    struct Expense {
//        var id: UUID = UUID()
        var amount: Float
        var date: Date
        var type: ExpenseType
    }
    
    enum ExpenseType: String, Identifiable, CaseIterable, Codable {
        var id: Self {self}
        case housing
        case food
        case transportation
        case insurance
        case care
        case entertainment
        case education
        case travel
        case debt
        case saving
        case investement
        case others
    }
}

public struct FirebaseWalletResponse: Decodable {
    var currentBalance: Float
}
