//
//  theGame.swift
//  cardGameCode
//
//  Created by Student7 on 19/06/2023.
//

import SwiftUI

struct TheGame: View {
    @EnvironmentObject var gameManager: GameManager
    
    var textFieldText:String
    var isUserOnLeftSide: Bool
    @State var eastSide: String
    @State var westSide: String
    
    @State  private var showWinnerWindow = false
    
    
    init(textFieldText: String, isUserOnLeftSide: Bool) {
        self.textFieldText = textFieldText
        self.isUserOnLeftSide = isUserOnLeftSide
        _eastSide = State(initialValue: isUserOnLeftSide ? "PC" : textFieldText)
        _westSide = State(initialValue: isUserOnLeftSide ? textFieldText : "PC")
    }
    
    
    var body: some View {
        NavigationStack() {
            if showWinnerWindow {
                WinnerWindow(stringWinner:gameManager.stringWinner, intWinner: gameManager.intWinner)
            } else {
                ZStack {
                    VStack{
                        VStack(spacing: 0) {
                            
                            HStack {
                                Label(westSide, systemImage: "")
                                    .padding()
                                    .foregroundColor(.black)
                                    .font(.system(size:30))
                                Spacer()
                                Label(eastSide, systemImage: "")
                                    .padding()
                                    .foregroundColor(.black)
                                    .font(.system(size:30))
                            }
                            HStack {
                                
                                Label("\(gameManager.score1)", systemImage: "")
                                    .padding(.leading, 30)
                                    .foregroundColor(.black)
                                    .font(.system(size:30))
                                
                                Spacer()
                                Label("\(gameManager.score2)", systemImage: "")
                                    .padding(.trailing, 25)
                                    .foregroundColor(.black)
                                    .font(.system(size:30))
                                
                            }
                            Spacer()
                        }
                        
                        
                        HStack {
                            Image(gameManager.currentCard1)
                                .resizable()
                                .scaledToFill()
                                .frame(width:200, height:250)
                            
                            
                            VStack{
                                Image("stop_watch")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:100, height:100, alignment: .center)
                                
                                Label("\(gameManager.countDownTimer)", systemImage: "")
                                    .onReceive(gameManager.timer) { _ in
                                        gameManager.handleTime()
                                        if(gameManager.timerRunning == false) {
                                            gameManager.handleGame(westSide: self.westSide, eastSide: self.eastSide)
                                            
                                        }
                                    }
                                    .foregroundColor(.black)
                                    .font(.system(size:30))
                            }
                            Image(gameManager.currentCard2)
                                .resizable()
                                .scaledToFill()
                            .frame(width:200, height:250)                        }
                        Spacer()
                    }
                }
            }  }.onChange(of: gameManager.winnerReadyToMove) { status in if gameManager.winnerReadyToMove {showWinnerWindow = true       }
                
            }.onDisappear {
                gameManager.resetGame()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //gameManager.handleGame(westSide: self.westSide, eastSide: self.eastSide)                }
                    
                }
            }
    }
    
    struct TheGame_Previews: PreviewProvider {
        static var previews: some View {
            TheGame(textFieldText: "",isUserOnLeftSide: true).previewInterfaceOrientation(.landscapeRight).environmentObject(GameManager())
        }
    }
}



