//
//  WinnerWindow.swift
//  cardGameCode
//
//  Created by Student7 on 19/06/2023.
//

import SwiftUI

struct WinnerWindow: View {
    var stringWinner : String
    var intWinner : Int
    
    init(stringWinner: String, intWinner: Int) {
        self.stringWinner = stringWinner
        self.intWinner = intWinner
    }
    var body: some View {
        NavigationStack {
            VStack(spacing:15) {
                Spacer()
                HStack {
                    Label("Winner:", systemImage: "")
                        .foregroundColor(.black)
                        .font(.system(size:40))
                    
                    Label(stringWinner, systemImage: "")
                        .foregroundColor(.black)
                        .font(.system(size:40))
                }
                HStack {
                    Label("Score:", systemImage: "")
                        .foregroundColor(.black)
                        .font(.system(size:30))
                    
                    Label("\(intWinner)", systemImage: "")
                        .foregroundColor(.black)
                        .font(.system(size:30))
                }.padding(.bottom, 100)
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                    Text("Back to menu".uppercased())
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            Color.gray.cornerRadius(10)
                                .shadow(radius:10))
                }
            }
        }
    }
    
    struct WinnerWindow_Previews: PreviewProvider {
        static var previews: some View {
            WinnerWindow(stringWinner: "",intWinner:0) .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
