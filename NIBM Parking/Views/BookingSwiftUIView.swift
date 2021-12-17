//
//  BookingSwiftUIView.swift
//  NIBM Parking
//

import SwiftUI
import CodeScanner

struct BookingSwiftUIView: View {
    
    @State var isPresentingScanner = false
    @State var slots: [String] = [];
    @State private var slot_no = 0;
    @State var vNo = " "
    @State var regid = " "
    @State var btn_disable = true;
    @State var type = "normal"
    @State var user: [String: Any] = ["":""];
    @State var title = ""
    @State var alert = false
    @State var time_slot = 0
    
    var controller = BookingController();
    var ucontroller = UserController();
    var location = LocationController();
    
    var scannerSheet : some View{
        CodeScannerView(
            codeTypes: [.qr],
            completion: {res in
                if case let .success(code) = res{
                    self.isPresentingScanner = false
                    if let i = self.slots.firstIndex(of:code) {
                        self.slot_no = i;
                    }
                }
            })
    }
        
        
    var body: some View {
        VStack{
            Text("Booking")
                .fontWeight(.bold)
            Spacer()
            
             Text(" Vehicle Number :    "+"\(vNo)")
                .font(.body)
                           .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
             Text("Registration No :   "+"\(regid)")
                           .font(.body)
                           .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                       
                       
            Picker(selection: $slot_no ,label: Text("Picker")) {
                ForEach(0..<slots.count, id: \.self) { index in
                        Text("\(self.slots[index])")
                }
            }.frame(height: 30.0).padding(.all,100)
            
            Picker("Picker",selection: $time_slot, content:{
                Text("1 Hour").tag(0)
                Text("2 Hour").tag(1)
                Text("3 Hour").tag(2)
                Text("4 Hour").tag(3)
            }).frame(height: 30.0).padding(.top,80)
            .pickerStyle(SegmentedPickerStyle())
            .scaledToFit().scaleEffect(CGSize(width: 1, height: 1))
            
           HStack(spacing: 40){
            
            Button(action: {
                self.Reserve()
                
            }, label:{
                Text("RESERVE")
                    .fontWeight(.bold)
                    .foregroundColor(Color(.white))
                    .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }).disabled(btn_disable)
            .background(Color(.systemGreen))
            .cornerRadius(6).alert(isPresented: self.$alert){()->Alert in
                return Alert(title: Text("\(self.title)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
            
                                       
            Button(action: {
                self.isPresentingScanner = true
                }) {
                Text("Scan QR")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: 100, height: 50, alignment: .center)
                }
            .background(Color(.systemBlue))
            .cornerRadius(6)
            .sheet(isPresented: $isPresentingScanner){
                self.scannerSheet
            }
            
           }.padding(.all, 40)
            
        }.onAppear(){
            self.GetSlots()
            self.getUserData()
        }
        
    }
    
    func GetSlots() {
        controller.findAvailableSlots() {(success) -> Void in
            self.slots = success;
            btn_disable = false;
        }
    }
    
    func getUserData(){
        ucontroller.getUserData() {(success) -> Void in
            let regid = success["registerid"] as! Int64;
            self.regid = String(regid);
            self.vNo = success["vehicle_no"] as! String
            self.user = success
        }
    }
    
    func Reserve(){
        
        if(!btn_disable){
            
//            if(location.isAllowed){
//                title = "Please Enable Location";
//                alert = true
//                return;
//            }else{
//                if(!location.isUserWithin1Km){
//                    title = "Booking is available within 1km to parking area";
//                    alert = true
//                    return;
//                }
//            }
            
            btn_disable = true;
            let no = slots[slot_no]
            if(no.contains("vip")){
                type = "vip"
            }else{
                type = "normal"
            }
            
            let date = NSDate();
            let calender = Calendar.current;
            let h = calender.component(.hour, from: date as Date)
            let m = calender.component(.minute, from: date as Date)
            let time = "\(String(format: "%02d", h)):\(String(format: "%02d", m))"
           
            controller.reserveSlot(type: type,id: no, user: user,time: time,timeid: time_slot) {(success) in
                if(success){
                    title =  "Succesfully Reserved";
                    alert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.GetSlots();
                    }
                }
            }
        }
    }
}

//struct BookingSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingSwiftUIView()
//    }
//}
