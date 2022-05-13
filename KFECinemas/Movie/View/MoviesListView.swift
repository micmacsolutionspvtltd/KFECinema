//
//  MoviesListView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct MoviesListView: View {
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    private var symbols = ["food1", "food2", "food3","food4","food5","food6","food1", "food2", "food3","food4","food5","food6"]
    var body: some View {
        ScrollView(showsIndicators:false){
            HStack {
                Button(action:{
                    
                }){
                    
                    Image(systemName:  "arrow.left").foregroundColor(.white)
                }
                Text("MOVIES").foregroundColor(.white).font(.system(size: 20,weight: .bold))
                Spacer()
                
            }
            .padding()
            .background(Color(uiColor: UIColor.red))
            
            LazyVGrid(columns: twoColumnGrid,spacing: 10) {
                ForEach(0...symbols.count-1,id:\.self) { value in
                    VStack {
                        Image(symbols[value]).resizable().frame(height:200).cornerRadius(10)
                        Text("KRACK").foregroundColor(.white).padding(.bottom,2)
                        Text("Telugu/ U/A").foregroundColor(.white)
                    }
                }.padding()
                }
           
        }.background(Color("ColorAppGrey")).navigationBarHidden(true)
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
