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
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    private var symbols = ["food1", "food2", "food3","food4","food5","food6","food1", "food2", "food3","food4","food5","food6"]
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
                    ForEach(dashboardServices.moneCinemas, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movie:movie)) {
                        MovieCardView(model: movie).frame(width: 150, height: 250)
                        }
                        }.padding()
                    }
            }else{
                LazyVGrid(columns: twoColumnGrid,spacing: 10) {
                    ForEach(dashboardServices.spiceCinemas, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movie:movie)) {
                        MovieCardView(model: movie).frame(width: 150, height: 250)
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
