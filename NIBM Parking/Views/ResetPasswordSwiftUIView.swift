//
//  ResetPasswordSwiftUIView.swift
//  NIBM Parking
//

import SwiftUI

struct ResetPasswordSwiftUIView: View {
    
    @State var email = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
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
                .padding(.top, 0).accessibility(identifier: "mail")
          
            Button(action: {
                self.Verify()
            }) {
                Text("Sign in")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                 .frame(width: UIScreen.main.bounds.width - 100)
            }
            .background(Color(.systemBlue)).accessibility(identifier: "subBtn")
            .cornerRadius(6)
            .padding(.top, 15)
            .alert(isPresented: $alert){()->Alert in
                return Alert(title: Text("\(self.title)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
            
            HStack(spacing: 5){
               
                Button(action: {
                   self.Back()
                    
                }) {
                    Text("Back Home")
                        .fontWeight(.medium)
                        .foregroundColor(Color(.blue))
                }.padding(.top, 10.0)
                
            }.padding(.top, 25)
        }
        .padding(.horizontal, 25)
        
    }
    
    func Back(){
        app.SE_VIEW = "LoginSwiftUIView"
        app.TAB_TAG = 4
    }
    
    func Verify(){
        if(email.isEmpty){
            title = "Invalid Email";
            alert = true;
        }else{
            controller.resetPassword(email: email) {(success) in
                if(success){
                    title = "Success";
                    alert = true;
                }
            }
        }
    }
}

//struct ResetPasswordSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordSwiftUIView()
//    }
//}
