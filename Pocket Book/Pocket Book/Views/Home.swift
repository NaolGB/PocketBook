import SwiftUI

struct Home: View {
    @EnvironmentObject var dataStore: DataStore
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Here is your PocketBook")
                    .font(.title)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Deposit") {
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add expense") {
                        
                    }
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
