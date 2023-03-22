import SwiftUI
import Firebase

struct Login: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State var newUserUID: String = ""
    @State var registerSheetOpen: Bool = false
    @State var loginFailed: Bool = false
    @State private var loginSuccess: Bool = false
    @State var registerFailedValidation: Bool = false
    @State var registerFailedError: Bool = false
    
    var body: some View {
        if loginSuccess {
            Home()
                .environmentObject(dataStore)
        }
        else{
            loginView
        }
    }
    
    var loginView: some View {
        VStack {
            Text("PocketBook")
                .font(.largeTitle)
                .padding([.bottom], 50)
            
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .autocapitalization(UITextAutocapitalizationType.none)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding([.bottom], 25)
                Button("Login") {
                    login()
                }
                .buttonStyle(.borderedProminent)
                .disabled(email == "" || password == "")
            }
            .padding([.bottom], 50)
            
            //            login error message
            if loginFailed {
                Text("Login failed, email/passowrd incorrect!")
                    .foregroundColor(Color.red)
                    .padding([.bottom], 50)
            }
            
            HStack {
                Text("New to PocketBook?")
                Button("Signup") {
                    registerSheetOpen.toggle()
                }
            }
        }
        .padding()
        
        //        registration view
        .sheet(isPresented: $registerSheetOpen) {
            VStack {
                Text("Signup")
                    .font(.largeTitle)
                    .padding([.bottom], 50)
                
                VStack {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .autocapitalization(UITextAutocapitalizationType.none)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(.roundedBorder)
                }
                .padding([.bottom], 50)
                
                Button("Signup") {
                    if isValidEmail(email) && password == confirmPassword {
                        register()
                    }
                    else {
                        registerFailedValidation = true
                    }
                }
                .buttonStyle(.borderedProminent)
                
                //                registraiton error messages
                VStack {
                    if registerFailedValidation {
                        Text("Email invalid or passwords don't match")
                            .foregroundColor(Color.red)
                    }
                    
                    if registerFailedError {
                        Text("Registraiton failed, please try again\nUse a stronger password!")
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                
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
    
//   ------------------------------------
    //    Firebase Auth
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
//                enable static registration failed message
                registerFailedError = true
            }
            else{
                newUserUID = (result?.user.uid)!
                dataStore.createNewUserDocument(userUID: newUserUID)
                registerSheetOpen = false
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
//                enable static login failed message
                loginFailed = true
            }
//            get userUID
            else {
                let currentUser = Auth.auth().currentUser
                if let currentUser = currentUser {
                    let userUID = currentUser.uid
                    dataStore.setUserUID(userUID: userUID)
                    loginSuccess = true
                }
            }
        }
    }
//    ------------------------------------
    
    //    https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    //    email validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
