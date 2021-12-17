//
//  ProfileSwiftUIView.swift
//  NIBM Parking
//

import SwiftUI

struct ProfileSwiftUIView: View {
    @State var name = ""
    @State var nic = ""
    @State var mobileNumber = ""
    @State var regid = ""
    @State var vehicalNumber = ""
    
    var controller = UserController();
    @ObservedObject var app : AppController
    
    var body: some View {
        VStack{
            Text("Settings")
                .fontWeight(.bold)
            Spacer()
            Text("My info")
                .fontWeight(.bold).padding(.top, 50.0)
            VStack(alignment: .leading,spacing: 10){
                HStack( spacing: 70){
                    VStack(alignment: .leading){
                        Text("Name :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 15.0)
                        Text("NIC :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                        Text("Registration No :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                        Text("Vehicle No :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                        Text("Mobile No :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                    }
                    VStack(alignment: .leading){
                        Text(name).fontWeight(.semibold).padding(.top, 15.0)
                        Text(nic).fontWeight(.semibold).padding(.top, 40.0)
                        Text(regid).fontWeight(.semibold).padding(.top, 40.0)
                        Text(vehicalNumber).fontWeight(.semibold).padding(.top, 40.0)
                        Text(mobileNumber).fontWeight(.semibold).padding(.top, 40.0)
               
                
                    }
                    
                }
                    
            }.foregroundColor(.blue).padding(.all,10)
            Spacer()
            Button(action: {
                self.Logout()
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                 .frame(width: 100, height: 50)
            }
            .background(Color(.systemBlue))
            .cornerRadius(6)
            .padding(.bottom, 150)
        }.onAppear(){
            self.getUserData();
        }
    }
    
    func Logout(){
        controller.logOut();
        app.IS_LOGIN = false;
        app.TAB_TAG = 1
    }
    
    func getUserData(){
        controller.getUserData() {(success) -> Void in
            let regid = success["registerid"] as! Int64;
            self.regid = String(regid);
            self.name =  success["name"] as! String
            self.vehicalNumber = success["vehicle_no"] as! String
            self.nic = success["nic"] as! String
            self.mobileNumber = success["mobile"] as! String
        }
    }
}
        

//struct ProfileSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileSwiftUIView()
//    }
//}
