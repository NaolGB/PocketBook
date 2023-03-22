import Foundation

struct Wallet {
    var currentBalance: Float
    var expenses: [Expense]
    
    struct Expense: Identifiable {
        var id: UUID = UUID()
        var amount: Float
        var date: Date
        var type: ExpenseType
    }
    
    enum ExpenseType: String, Identifiable, CaseIterable {
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
    }
}
