import SwiftUI

struct Home: View {
    @EnvironmentObject var dataStore: DataStore
    
    
    var body: some View {
        VStack{
            Text("userUID: \(dataStore.getUserUID())")
            Text("Here is your PocketBook")
                .font(.title)
            
            HStack{
                Button("Deposit") {
                    
                }
                .buttonStyle(.borderedProminent)
                Button("Spend") {
                    
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
