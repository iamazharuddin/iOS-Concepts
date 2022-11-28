//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by Azharuddin 1 on 23/10/22.
//
import Foundation

enum Player :String{
     case a = "Azharuddin"
     case b = "Tarannum"
}

class TicTacToeViewModel : ObservableObject{
    @Published var board = [[String]]()
    @Published var player = Player.a
    @Published var wonPlayer : Player?
    @Published var showResult = false
    var message = ""
    init(){
       initialBoardSetup()
    }
    
    
    func initialBoardSetup(){
         board =  Array(repeating: Array(repeating: "", count : 3), count : 3)
         player = Player.a
         wonPlayer = nil
    }
    
    func checkWinner(player : Player) {
        let value =  player == .a ? "X" : "O"
        if  checkRowWinner(value){
            wonPlayer = player
        
        }
                
        if  checkColumnWinner(value){
            wonPlayer = player
        }
        
        if  checkDiagonals(value){
            wonPlayer = player
        }
        
        
        if let wonPlayer = wonPlayer {
            message = "\(wonPlayer.rawValue) has won the game"
            showResult.toggle()
        }else{
            for r in 0..<board.count{
                for c in 0..<board[r].count {
                    if board[r][c].isEmpty{
                        return
                    }
                }
            }
            message = "Match Draw"
            showResult.toggle()
        }
    }
    
   private  func checkRowWinner(_ value : String) -> Bool{
        for row in  board {
            if  row[0] == value && row[1] == value &&  row[2] == value{
                return true
            }
        }
        return false
    }
    
    
    private func checkColumnWinner(_ value : String) -> Bool{
        for col in 0..<board[0].count{
            if board[0][col] == value && board[1][col] == value && board[2][col] == value{
                return true
            }
         }
        
        return false
    }
    

    
    private func checkDiagonals(_ player : String) -> Bool{
        var diagonal = 0
        var antiDiagonal = 0
         for r in 0..<board.count{
            for c in 0..<board[0].count{
                if player == board[r][c]{
                    if r == c{
                       diagonal += 1
                    }
                    
                    if r == 2 - c{
                       antiDiagonal += 1
                    }
                }
            }
        }
        return diagonal == 3 || antiDiagonal == 3
    }
    
    


}
