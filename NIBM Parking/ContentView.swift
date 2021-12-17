//
//  ContentView.swift
//  NIBM Parking
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appController = AppController();
    
    var body: some View {
        TabView(selection: $appController.TAB_TAG) {
        HomeSwiftUIView()
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }.tag(1)
            
        if(appController.IS_LOGIN){
            BookingSwiftUIView().tabItem {
                        Image(systemName: "book")
                        Text("Booking")
                }.tag(2)
            ProfileSwiftUIView(app: appController).tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(3)
        }else{
            if(appController.SE_VIEW=="LoginSwiftUIView"){
                LoginSwiftUIView(app: appController).tabItem {
                            Image(systemName: "person")
                            Text("Login")
                    }.tag(4)
            }else
            if(appController.SE_VIEW=="SignUpSwiftUIView"){
                SignUpSwiftUIView(app: appController).tabItem {
                            Image(systemName: "person")
                            Text("Register")
                        }.tag(5)

            }else
            if(appController.SE_VIEW=="ResetPasswordSwiftUIView"){
                ResetPasswordSwiftUIView(app: appController).tabItem {
                            Image(systemName: "person")
                            Text("Reset Password")
                        }.tag(6)
            }
        }
    }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
