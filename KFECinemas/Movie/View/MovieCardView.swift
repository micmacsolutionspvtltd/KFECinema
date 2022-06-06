//
//  MovieCardView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct MovieCardView: View {
    var model:AllFilms
    var body: some View {
        VStack(alignment: .leading){
            if model.imageURL == ""{
                Image("movieImgLatest").renderingMode(.original)
                    .resizable().cornerRadius(5)
                    .frame(width:150,height: 200)
            }else{
                MoviesImageView(withURL: model.imageURL ?? "")
            }
            VStack(alignment:.center,spacing:6) {
                Text(model.filmStrTitle?.capitalizingFirstLetter() ?? "").clipped().foregroundColor(.white).frame(maxHeight:20).font(.system(size: 16,weight: .bold))
        
                Text( "\(model.filmStrShortNameAlt ?? "") \(model.filmStrCensor ?? "")").foregroundColor(.white).opacity(0.7).font(.system(size: 13,weight: .bold))
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)).frame(maxWidth:.infinity)
           
        }.navigationBarHidden(true)
    }
}

//struct MovieCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieCardView(model:AllFilms(filmStrTitle:"sdadsfs")).previewLayout(.fixed(width: 240, height: 400))
//    }
//}


struct MovieModel: Identifiable {
    let id = UUID()
    let name: String
}


struct MoviesModel: Identifiable,Hashable {
    let id = UUID()
    let imageName: String
}


extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
