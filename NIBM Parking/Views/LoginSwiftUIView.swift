//
//  LoginSwiftUIView.swift
//  NIBM Parking
//

import SwiftUI

struct LoginSwiftUIView: View {
    @State var email = ""
    @State var pass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    
    var controller = UserController();
    @ObservedObject var app : AppController
    
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    
    var body: some View{
        VStack(){
            Image("loginimg").resizable().frame(width: 200.0, height: 200.0, alignment: .top)
            
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            TextField("Email Address",text:self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                .padding(.top, 0)
            
            HStack(spacing: 15){
                VStack{
                    if self.visible {
                        TextField("Password", text: self.$pass)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: self.$pass)
                            .autocapitalization(.none)
                    }
                }
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
            .stroke(borderColor,lineWidth: 2))
            .padding(.top, 10)
            
            HStack{
                Spacer()
                Button(action: {
                    self.ResetPassword()
                }) {
                    Text("Forget Password")
                        .fontWeight(.medium)
                        .foregroundColor(Color(.blue))
                }.padding(.top, 10.0).accessibility(identifier: "fPassBtn")
            }
            
            // Sign in button
            Button(action: {
                self.Login()
            }) {
                Text("Sign in")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                 .frame(width: UIScreen.main.bounds.width - 100)
            }
            .background(Color(.systemBlue))
            .cornerRadius(6)
            .padding(.top, 15)
            .alert(isPresented: $alert){()->Alert in
                return Alert(title: Text("\(self.title)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
            
            HStack(spacing: 5){
                Button(action: {
                    self.Register()
                }) {
                    Text("Don't have an account? Register now")
                        .fontWeight(.medium)
                        .foregroundColor(Color(.blue))
                }.padding(.top, 10.0)
                
               
                
            }.padding(.top, 25)
            
            Button(action:{
                UIApplication.shared.open(URL(string: "https://www.nibm.lk")!)
            }, label:{
                Text("Terms & Conditions").fontWeight(.regular).padding()
            }).padding(.top, 10)
        }.onAppear(){
            self.Check()
        }
        .padding(.horizontal, 25)
        
    }
    
    func Login(){
        controller.login(mail: email, password: pass) {(success) in
            if(success){
                app.IS_LOGIN = true;
            }else{
                title = "Email or Password Invalid"
                alert = true;
            }
        }
    }

    func ResetPassword(){
        app.SE_VIEW = "ResetPasswordSwiftUIView"
        app.TAB_TAG = 6
    }
    
    func Register(){
        app.SE_VIEW = "SignUpSwiftUIView"
        app.TAB_TAG = 5
    }
    
    func Check(){
        controller.loginCheck() {(success) -> Void in
            app.IS_LOGIN = success
        }
    }
}

//struct LoginSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginSwiftUIView()
//    }
//}
