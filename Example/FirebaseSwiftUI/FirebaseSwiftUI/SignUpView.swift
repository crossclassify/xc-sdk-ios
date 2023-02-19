//
//  SignUpView.swift
//  FirebaseLogin
//
//  Created by Mavis II on 9/2/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import SwiftUI
import Firebase
import CrossClassify


struct actIndSignup: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var agreeCheck: Bool = false
    @State var errorText: String = ""
    @State private var showAlert = false
    @State private var shouldAnimate = false
    
    var alert: Alert {
        
        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.password = ""
            self.agreeCheck = false
            self.errorText = ""
            })
       }
    
    var body: some View {
        
        VStack {
             
            AppTitleView(Title: "Sign Up")
        
            VStack(spacing: 10) {
                          
                           
                    Text("Email").font(.title).fontWeight(.thin).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                TrackedTextField("user@domain.com", text: $emailAddress, id: "email", trackContent: true, cc: CrossClassify.shared).textContentType(.emailAddress).autocapitalization(.none)
                
                        Text("Password").font(.title).fontWeight(.thin)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                TrackedSecureField("Enter a password", text: $password, id: "password", cc: CrossClassify.shared)
                    
                    Toggle(isOn: $agreeCheck)
//                    Toggle(isOn: $agreeCheck.track("signup", "agreeCheck", true))
                    {
                        Text("Agree to the Terms and Condition").fontWeight(.thin)
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                    Button(action: {
                        
                        CrossClassify.shared.submit()
                        
                        if(self.agreeCheck){
                            print("Printing outputs" + self.emailAddress, self.password  )
                            self.shouldAnimate = true
                            self.sayHelloWorld(email:self.emailAddress, password:self.password)
                        }
                        else{
                             self.errorText = "Please Agree to the Terms and Condition"
                        }
                    }) {
                        
                    Text("Sign Up")
                        
                    }
                
                    Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                    actIndSignup(shouldAnimate: self.$shouldAnimate)
                
                     Spacer()

                    }.padding(10)

        }.edgesIgnoringSafeArea(.top).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(Color.white)
            .onAppear{CrossClassify.shared.track(pageName: "signup", formName: "signup")}
            .onDisappear{CrossClassify.shared.stopTrack()}
        
        
        .alert(isPresented: $showAlert, content: { self.alert })
//        .environment(\.selectedFocusIndex, $selectedFocusIdx)

    }
    
    
    func sayHelloWorld(email: String, password: String) {
       
        
           Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let user = authResult?.user, error == nil else {
             
                let errorText: String  = error?.localizedDescription ?? "unknown error"
                self.errorText = errorText
                
              return
            }
            
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if let error = error {
                    self.errorText = error.localizedDescription
                  return
                }
                self.showAlert.toggle()
                
                self.shouldAnimate = false
                
            }
            
            print("\(user.email!) created")
            
        }
        
        
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
