//
//  MovieCardView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct MovieCardView: View {
    var model:AllFilms
    @State var imageData : GetFinalDataImage
    var body: some View {
        VStack(alignment: .leading){
            if imageData.image == "" || imageData.image == nil{
                Image("movieImgLatest").renderingMode(.original)
                    .resizable().cornerRadius(5)
                    .frame(width:150,height: 200)
            }else{
                MoviesImageView(withURL: Endpoint.showMovieImage.url + (imageData.image ?? ""))
            }
            VStack(alignment:.center,spacing:6) {
                Text(model.filmStrTitle?.capitalizingFirstLetter() ?? "").clipped().foregroundColor(.white).frame(maxHeight:20).font(.system(size: 16,weight: .bold))
                HStack{
                    Text( "\(model.filmStrShortNameAlt ?? "")").foregroundColor(.white).opacity(0.7).font(.system(size: 13,weight: .bold))
                    if model.filmStrCensor == "A"{
                        Text( "\(model.filmStrCensor ?? "")").foregroundColor(.white).opacity(0.7).minimumScaleFactor(0.4).font(.system(size: 13,weight: .bold)).frame(width : 20, height:20).background(Color.red).cornerRadius(20)
                    }else{
                        Text( "\(model.filmStrCensor ?? "")").foregroundColor(.black).opacity(0.7).minimumScaleFactor(0.4).font(.system(size: 13,weight: .bold)).frame(width : 20, height:20).background(Color.white).cornerRadius(20)
                    }
                    
                }
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
