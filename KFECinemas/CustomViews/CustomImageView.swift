//
//  CustomImageView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 05/04/22.
//

import SwiftUI

struct BannerImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
  //  @State var cornerRadiuss : CGFloat? = 0

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:UIScreen.main.bounds.size.width,height: 200)
              //  .cornerRadius(cornerRadiuss ?? 0)
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
                    
        }
    }
}

struct MoviesImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable().cornerRadius(5)
                .aspectRatio(contentMode: .fit)
                .frame(width:150,height: 200)
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage(named: "food1")!
                    
        }
    }
}

struct FoodImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable().cornerRadius(5)
                .aspectRatio(contentMode: .fit)
                .frame(width:140,height: 180)
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage(named: "food1")!
                    
        }
    }
}

struct SpiceKitchenFoodView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        
            Image(uiImage: image)
                .resizable().cornerRadius(5)
                .aspectRatio(contentMode: .fit)
                .frame(width:65,height: 65)
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage(named: "food1")!
                    
        }
    }
}
                                                                                                           
