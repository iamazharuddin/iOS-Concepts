//
//  NewsFeedListViewModel.swift
//  NewsFeed
//
//  Created by Azharuddin 1 on 26/07/22.
//

import Foundation

class NewsFeedListViewModel : ObservableObject{
    @Published var newsList = [NewsArticle]()
    @Published var isLoading = true
    
    init(){
        getNewsFeedData()
    }
    
    
    func getNewsFeedData(){
        isLoading = true
        NewsFeedApiManager().getNewsFeedData { [weak self] (model, error) in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.isLoading = false
                if let newsList = model?.articles{
                    weakSelf.newsList = newsList
                }else{
//                    print(error)
                }
            }
            
        }
    }
    
}
