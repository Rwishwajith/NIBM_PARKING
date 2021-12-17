//
//  SignUpSwiftUIView.swift
//  NIBM Parking
//

import SwiftUI

struct SignUpSwiftUIView: View {
    @State var username = ""
    @State var email = ""
    @State var pass = ""
    @State var mobilenumber = ""
    @State var nibmID = ""
    @State var vehicalid = ""
    @State var nic = ""
    
    @State var color = Color.black.opacity(0.7)

    var controller = UserController();
    var validation = ValidationController();
    @ObservedObject var app : AppController
    
    @State var visible = false
    @State var revisible = false
    
    @State var alert = false
    @State var error = ""
    
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    
    var body: some View{
   
        
        VStack(alignment: .leading){
            
            GeometryReader{_ in
                ScrollView(.vertical){
                VStack{
                    Image("loginimg").resizable().frame(width: 200.0, height: 200.0, alignment: .top)
                    
                    Text("Create a new account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 0)
                    
                    TextField("Username",text:self.$username)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                        .padding(.top, 0)
                    
                    TextField("Email Address",text:self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
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
                                .opacity(10)
                        }
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(self.borderColor,lineWidth: 2))
                    .padding(.top, 0)
            
                    
                   
                    
                   
                    
                    TextField("Mobile Number",text:self.$mobilenumber)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                        .padding(.top, 0)
                    
                    TextField("NIC",text:self.$nic)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                        .padding(.top, 0)
                    
           
                    
                    TextField("Vehical Number",text:self.$vehicalid)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                        .padding(.top, 0)
                    
                    
                    // Sign up button
                    Button(action: {
                        self.Register()
                    }) {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: 100, height: 50)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(6)
                    .padding(.top, 15)
                    .alert(isPresented: self.$alert){()->Alert in
                        return Alert(title: Text("\(self.error)"), dismissButton:
                            .default(Text("OK").fontWeight(.semibold)))
                    }
                    
                    HStack(spacing: 5){
                       
                        Button(action: {
                           self.Back()
                            
                        }) {
                            Text("Back to Login")
                                .fontWeight(.medium)
                                .foregroundColor(Color(.blue))
                        }.padding(.top, 10.0)
                        
                    }.padding(.all, 25)
                    
                }
                .padding(.horizontal, 25)
                }
            }
        }
    }
    
    func Back(){
        app.SE_VIEW = "LoginSwiftUIView"
        app.TAB_TAG = 4
    }
    
    func Register(){
        if(email.isEmpty){
            error = "Invalid Email"
            alert = true;
            return;
        }
        if(!validation.checkValidEmail(email)){
            error = "Email Format Invalid"
            alert = true;
            return;
        }
        if(pass.isEmpty){
            error = "Please Enter Password"
            alert = true;
            return;
        }
        if(!validation.checkValidPassword(pass)){
            error = "Password at least 8 characters"
            alert = true;
            return;
        }
        if(username.isEmpty){
            error = "Please Enter Name"
            alert = true;
            return;
        }
        if(nic.isEmpty){
            error = "Please Enter NIC"
            alert = true;
            return;
        }
        if(mobilenumber.isEmpty){
            error = "Please Enter Mobile No"
            alert = true;
            return;
        }
        if(vehicalid.isEmpty){
            error = "Please Enter Vehicle No"
            alert = true;
            return;
        }

        controller.signUp(email: email, password: pass, name: username,mobile:mobilenumber, vehicalid: vehicalid, nic: nic) {(success) in
            if(success){
                error =   "Success"
                alert = true;
                app.IS_LOGIN = true
            }else{
                error =  "Failed"
                alert = true;
            }
        }
    }


}

//struct SignUpSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpSwiftUIView()
//    }
//}
