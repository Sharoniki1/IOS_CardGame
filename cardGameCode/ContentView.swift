//
//  ContentView.swift
//  cardGameCode
//
//  Created by Student7 on 18/06/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State var textFieldText: String = ""
    @State var isNameEntered: Bool = false
    @State var isTextChanged: Bool = false
    @State var isLocationEnable: Bool = false
    @State var flag: Bool = false
    //@State var stringName: String = ""

    var isTextFieldEmpty: Bool {
        return textFieldText.isEmpty
    }
    var greetingText: String {
        if isNameEntered {
            return "Hi \(locationManager.stringName)"
        } else {
            return "Insert a name:"
        }
    }
   
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack{
                    Image("earth")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height:
                                geo.size.height, alignment: .center)
                        .opacity(1.0)
                    VStack{
                        if !isNameEntered {
                            TextField("Insert a name: ", text: $textFieldText)
                                .padding()
                                .background(Color.white.opacity(0.9).cornerRadius(10))
                                .foregroundColor(.black)
                                .font(.system(size:22))
                                .frame(width:170)
                        } else {
                            Text(greetingText)
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        HStack {
                            Label("West Side", systemImage: "")
                                .padding()
                                .foregroundColor(.white)
                                .font(.system(size:40))
                            
                            Spacer()
                           
                            NavigationLink(destination: TheGame(textFieldText:locationManager.stringName, isUserOnLeftSide:locationManager.isUserOnLeftSide).navigationBarBackButtonHidden(true)) {
                                Text("Start".uppercased())
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .padding(.horizontal, 20)
                                    .background(
                                        Color.gray.cornerRadius(10)
                                            .shadow(radius:10))
                            }
                            .opacity(!isTextFieldEmpty && locationManager.status ? 1.0 : 0.0)
                            .disabled(isTextFieldEmpty || !locationManager.status)
                            .simultaneousGesture(TapGesture().onEnded {locationManager.stringName = textFieldText
                                isNameEntered = true
                                    
                            })
                            Spacer()
                            Label("East Side", systemImage: "")
                                .padding()
                                .foregroundColor(.white)
                                .font(.system(size:40))
                        }
                    }
                }
            }
        }.onAppear {
            if !locationManager.stringName.isEmpty {
                textFieldText = locationManager.stringName
                locationManager.status = true
                isLocationEnable = true
                isNameEntered = true
            }
        }
    }
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().previewInterfaceOrientation(.landscapeRight)
                .environmentObject(LocationManager())
            
            
        }
        
    }
}
