//
//  MoviesListView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct MoviesListView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @EnvironmentObject var dashboardServices:DashboardServices
    @State var viewTheatre : String = "M1 Cinemas"
     let twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
   
    var body: some View {
        ScrollView(showsIndicators:false){
            HStack {
                Button(action:{
                    presentationMode.wrappedValue.dismiss()
                }){
                    
                    Image(systemName:  "arrow.left").foregroundColor(.white)
                }
                Spacer()
                Text("MOVIES").foregroundColor(.white).font(.system(size: 20,weight: .bold))
                Spacer()
                
            }
            .padding()
            .background(Color(uiColor: UIColor.red))
            if viewTheatre == "M1 Cinemas"{
                LazyVGrid(columns: twoColumnGrid,spacing: 10) {
                    ForEach(0..<(dashboardServices.finalMoneImageData.count), id: \.self) { movie in
                        NavigationLink(destination: MovieDetailView(movie:dashboardServices.moneCinemas[movie], imageData: dashboardServices.finalMoneImageData[movie])) {
                            MovieCardView(model: dashboardServices.moneCinemas[movie], imageData: dashboardServices.finalMoneImageData[movie]).frame(width: 150, height: 250)
                           
                        }
                        }.padding()
                    }
            }else{
                LazyVGrid(columns: twoColumnGrid,spacing: 10) {
                    ForEach(0..<dashboardServices.finalSpiceImageData.count, id: \.self) { movie in
                        NavigationLink(destination: MovieDetailView(movie:dashboardServices.spiceCinemas[movie], imageData: dashboardServices.finalSpiceImageData[movie] ) ) {
                            MovieCardView(model: dashboardServices.spiceCinemas[movie] , imageData : dashboardServices.finalSpiceImageData[movie]).frame(width: 150, height: 250)
                        }
                        }.padding()
                    }
            }
         
           
        }.background(Color("ColorAppGrey")).navigationBarHidden(true)
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
