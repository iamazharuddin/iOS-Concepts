//
//  NewsFeedListView.swift
//  NewsFeed
//
//  Created by Azharuddin 1 on 26/07/22.
//

import SwiftUI
struct NewsFeedListView: View {
    @StateObject var viewModel = NewsFeedListViewModel()
    var body: some View {
        ScrollView(.vertical){
            if viewModel.isLoading{
                ProgressView().frame(maxWidth:.infinity, maxHeight: .infinity)
            }else{
                LazyVStack{
                    ForEach(viewModel.newsList, id: \.uuid)
                    { model in
                        
                        NewsTile(model: model)
                    }
                }
            }
            
        }
    }
}

struct NewsFeedListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedListView()
    }
}



