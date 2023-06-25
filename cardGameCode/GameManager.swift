//
//  GameManager.swift
//  cardGameCode
//
//  Created by Student7 on 21/06/2023.
//

import Foundation

class GameManager: ObservableObject {
    
    @Published var countDownTimer = 3
    @Published var timerRunning = false
    @Published var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @Published var numberOfGames = 10
    
    private var imageNames1 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var imageNames2 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var backCard = "back_card"
    @Published var currentCard1 : String
    @Published var currentCard2 : String
    @Published var score1 = 0
    @Published var score2 = 0
    
    @Published var stringWinner : String = ""
    @Published var intWinner = 0
    
    @Published var winnerReadyToMove : Bool = false
    
    init(){
        currentCard1 = backCard
        currentCard2 = backCard
        
    }
    
    func resetGame() {
        score1 = 0
        score2 = 0
        currentCard1 = backCard
        currentCard2 = backCard
        imageNames1 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        imageNames2 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        stringWinner = ""
        intWinner = 0
        winnerReadyToMove = false
        numberOfGames = 10
    }

    
    func flipCards(){
        currentCard1 = backCard
        currentCard2 = backCard
        
    }
    
    
    func turnCards(){
        var index1 = 0
        var index2 = 0
        
        if numberOfGames>0{
            index1 = Int.random(in: 0..<numberOfGames)
            index2 = Int.random(in: 0..<numberOfGames)
        }
        
        currentCard1 = imageNames1[index1]
        imageNames1.remove(at: index1)
        
        currentCard2 = imageNames2[index2]
        imageNames2.remove(at: index2)
        
        
    }
    
    func handleScore(){
        if currentCard1 != backCard{
            if let value1 = Int(currentCard1) , let value2 = Int(currentCard2){
                if value1 > value2{
                    score1+=1
                }
                else if value1 < value2{
                    score2+=1
                }
               
            }
        }
    }
    
    func handleGame(westSide: String , eastSide: String) {
        handleScore()
       
        if numberOfGames > 0 {
            numberOfGames -= 1
            resetTimer()
            turnCards()
            
        }
        else{
            defineWinner(westSide: westSide, eastSide: eastSide)
            winnerReadyToMove = true
        }
    }
    
    
    func defineWinner(westSide: String , eastSide: String) {
        if score1 > score2 {
            intWinner = score1
            stringWinner = westSide
        } else if score1 < score2 {
            intWinner = score2
            stringWinner = eastSide
        } else {
            intWinner = score1 // doesn't matter which score because it is a tie
            if westSide != "PC" {
                stringWinner = westSide
            } else {
                stringWinner = eastSide
            }
        }
    }
    
    func resetTimer(){
        countDownTimer = 3
        timerRunning = true
        
    }
    
    func handleTime() {
        if countDownTimer > 0 && timerRunning {
            countDownTimer -= 1
        } else {
            timerRunning = false
            
        }
        
    }
    
    
    
}
