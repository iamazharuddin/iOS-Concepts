//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Azharuddin 1 on 23/10/22.
//

import SwiftUI

struct TicTacToe: View {
    @StateObject var viewModel = TicTacToeViewModel()
    var body: some View {
        VStack{
            Text("Tic Tac Toe")
                .foregroundColor(Color.black)
                .padding(.bottom, 40)
                .font(.system(size: 24, weight : .bold))
                
            
            ForEach(0..<viewModel.board.count, id:\.self){ r in
                HStack{
                    ForEach(0..<viewModel.board[r].count, id:\.self){c in
                        
                        Button {
                            let player  = viewModel.player
                            if  viewModel.player == Player.a{
                                viewModel.board[r][c] = "X"
                                viewModel.player = .b
                            }else{
                                viewModel.board[r][c] = "O"
                                viewModel.player = .a
                            }
                            viewModel.checkWinner(player: player)
                        } label: {
                            Text(viewModel.board[r][c])
                                .foregroundColor(Color.white)
                                .padding()
                                .cornerRadius(4)
                                .frame(width: 70, height: 70, alignment: .center)
                                .background(Color.gray)
                        }.disabled(!viewModel.board[r][c].isEmpty)
                    }
                }
            }
        }.alert(isPresented: $viewModel.showResult) {
            Alert(title:Text("Game"), message: Text(viewModel.message), dismissButton: .cancel(Text("OK"), action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewModel.initialBoardSetup()
                }
            }))
        }
    }
}

struct TicTacToe_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToe()
    }
}


class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        backtrack("", 0, 0, n) { result.append($0) }
        return result
    }
    
    func backtrack(_ current: String,_ open: Int,_ end: Int,_ max: Int, _ result: (String)->Void) {
        if current.count == max * 2 {
            result(current)
            return
        }
        
        if open < max { backtrack(current + "(", open + 1, end, max, result) }
        if end < open  { backtrack(current + ")", open, end + 1, max, result) }
    }
}
