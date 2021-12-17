//
//  HomeSwiftUIView.swift
//  NIBM Parking
//

import SwiftUI
import FirebaseDatabase

struct HomeSwiftUIView: View {
    
    var controller = HomeController();
    @State var all: [Any] = [];
   
    var body: some View {
        VStack(alignment: .center){
            Text("Home")
                .fontWeight(.bold)
            GeometryReader{geom in
                ScrollView(.vertical){
                    VStack(alignment: .center)
                    {
                        ForEach(0..<all.count, id: \.self)
                        { index in
                            
                            HStack(alignment: .center){
                                let ele = self.all[index] as! [DataSnapshot]
                                
                                ForEach(0..<ele.count, id: \.self) { ind in
                                    let status = ele[ind].childSnapshot(forPath: "status").value as! String;
                                    let name = ele[ind].childSnapshot(forPath: "name").value as! String;
                                    
                                    if status == "RESERVED" {
                                        let user = ele[ind].childSnapshot(forPath: "user").value as! [String:Any]
                                        SlotView(isVip: name.contains("vip"), isReserved: status=="RESERVED", slotName: name, vehicleno: user["vehicle_no"] as! String)
                                    }else{
                                        SlotView(isVip: name.contains("vip"), isReserved: status=="RESERVED", slotName: name, vehicleno: "")
                                    }
                                }
                            }
                        }
                    }.padding(.all,10).frame(width: geom.size.width)
                }
            }
            HStack(spacing: 15){
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Image(systemName:"xmark")
                            .font(.caption)
                            .foregroundColor(.green))
                Text("Reserved").font(.caption).foregroundColor(.blue)
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.blue)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Image(systemName:"star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow))
                Text("VIP")
                    .font(.caption)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.blue)
                    .frame(width: 20, height: 20)
                
                Text("Available")
                    .font(.caption)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
            }.padding(.all,10)
                
            
                             
        }.onAppear(){
            self.getAll();
        }
    }
    
    func getAll() {
        controller.getAll(){(success) -> Void in
            all = success.chunked(into: 3);
        }
    }
}

struct HomeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSwiftUIView()
    }
}

struct SlotView: View
{
    var isVip = true;
    var isReserved = true;
    var slotName = "";
    var vehicleno = "";
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6).stroke(isReserved ? Color.red : Color(.blue),lineWidth: 2)
                        .frame(width: 100, height: 100)
                        .background(isReserved ? Color(.blue) : Color.clear)
            VStack{
                if isReserved{
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                    Text(vehicleno).foregroundColor(.white)
                    Text(slotName).foregroundColor(.white)
                }else{
                    if isVip{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                    }
                    Text(slotName)
                }
                
                
            }
            
        }
    }
}


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
