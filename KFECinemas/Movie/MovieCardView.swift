//
//  MovieCardView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct MovieCardView: View {
    var model:MovieModel
    var body: some View {
        VStack(alignment: .leading){
            Image("movie1").resizable().cornerRadius(5)
            VStack(alignment:.center,spacing:6) {
                Text(model.name).foregroundColor(.white).font(.system(size: 20,weight: .bold))
        
                Text("#123 min").foregroundColor(.white).opacity(0.7).font(.system(size: 13,weight: .bold))
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)).frame(maxWidth:.infinity)
           
        }
        
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(model: MovieModel(name: "Naveen")).previewLayout(.fixed(width: 240, height: 400))
    }
}


struct MovieModel: Identifiable {
    let id = UUID()
    let name: String
}


struct MoviesModel: Identifiable,Hashable {
    let id = UUID()
    let imageName: String
}
