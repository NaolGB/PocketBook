import SwiftUI

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State var registerSheetOpen: Bool = false
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding([.bottom], 50)
            
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
                .padding([.bottom], 50)
            
            HStack {
                Text("New to PocketBook?")
                Button("Signup") {
                    registerSheetOpen.toggle()
                }
            }
        }
        .padding()
        .sheet(isPresented: $registerSheetOpen) {
            VStack {
                Text("Signup")
                    .font(.largeTitle)
                    .padding([.bottom], 50)
                
                VStack {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(.roundedBorder)
                }
                .padding([.bottom], 50)
                
                Button("Signup") {
                    
                }
                .buttonStyle(.borderedProminent)
                
                HStack {
                    Text("Already have an account?")
                    Button("Login") {
                        registerSheetOpen.toggle()
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
