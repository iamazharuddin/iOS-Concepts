//
//  NewsTile.swift
//  NewsFeed
//
//  Created by Azharuddin 1 on 26/07/22.
//

import SwiftUI

struct NewsTile: View {
    @State var expandDesc = false
    let model : NewsArticle
    var body: some View {
        HStack(alignment: .top){
            if let url = URL(string: model.urlToImage ?? ""){
                AsyncImage(
                           url: url,
                           content: { image in
                               image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120)
                                    .frame(height : 140)
                                    .clipShape(Rectangle())
                                    .padding(.leading, 8)
                           },
                           placeholder: {
                               ProgressView().frame(width: 120, height: 140, alignment: .center)
                           }
                       )
            }
         
            Spacer().frame(width: 20)
            
            VStack(alignment: .leading){
                Text(model.title ?? "").foregroundColor(Color.black).font(.title)
                    .lineLimit(2)
                
                Text(model.articleDescription ?? "")
                    .foregroundColor(Color.black).font(.body)
                    .lineLimit(expandDesc ? nil : 1)
                    .multilineTextAlignment(.leading)
            }
            
            
        }.onTapGesture {
            expandDesc = !expandDesc
        }

    }
}
