//
//  AppController.swift
//  NIBM Parking
//

import Foundation
class AppController: ObservableObject{
    @Published var IS_LOGIN = false;
    @Published var SE_VIEW = "LoginSwiftUIView";
    @Published var TAB_TAG : Int = 1;
}
