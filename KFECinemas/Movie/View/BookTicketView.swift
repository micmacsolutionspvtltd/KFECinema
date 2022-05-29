//
//  BookTicketView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 09/05/22.
//

import SwiftUI

struct BookTicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var movieServices:MovieServices
    var movie:AllFilms

   @State var daysOfWeek:[Date] = []
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack {
                HStack(alignment: .center) {
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        
                        Image(systemName:  "arrow.left").foregroundColor(.white).padding()
                    }
                    Spacer()
                    Text("BOOK TICKET")
                    Spacer()
                    
                }
                .padding()
                
                Text("\(movie.filmStrTitle ?? "")").foregroundColor(.white).font(.system(size: 14,weight: .bold)).padding(.top,40)
                Divider().foregroundColor(Constants.CustomColors.colorAppGrey)
                    HStack{
                        ForEach(daysOfWeek,id:\.self) { day in
                            DayItemView(date: day) {
                                let requestModel = ["Date":"\(day.currentDateOnly)","filmcode":"\(movie.filmStrCode ?? "")"]
                                movieServices.getAllshows(requestBody: requestModel)
                            }.frame(maxWidth: .infinity)
                                }
                    }
                VStack(alignment:.center){
                    ForEach(movieServices.shows,id:\.id) { shows in
                        showGridView(selectedTheatre:shows.cinemaStrName ?? "", shows: shows)
                                        }
                }
                
                
                
                
            }.foregroundColor(.white)
        }.onAppear(perform: {
            let daysOfWeek = Date().daysOfWeek(using: .gregorian)
            self.daysOfWeek = daysOfWeek
            let requestModel = ["Date":"\(Date().currentDateOnly)","filmcode":"\(movie.filmStrCode ?? "")"]
            movieServices.getAllshows(requestBody: requestModel)
            movieServices.selectedMovie = movie
        }).background(Color("ColorAppGrey")).ignoresSafeArea().navigationBarHidden(true)
    }
}

struct DayItemView:View {
    var date:Date
    @State var isClicked = false
    var onclicked:()->()
    
    var body: some View {
        VStack(spacing:10) {
            Text("\(date.currentDay)")
            Text("\(date.currentDayDate)")
            if isClicked {
                Divider().foregroundColor(.blue)
            }else{
                EmptyView()
            }
        }.onTapGesture {
            isClicked = true
            onclicked()
        }
    }
}

struct showGridView:View {
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    var selectedTheatre:String
    var shows:Shows
    @EnvironmentObject var movieServices:MovieServices
    var body: some View {
        if let shows = shows.shows {
            VStack(alignment:.leading){
                Text(selectedTheatre).font(.system(size: 18)).fontWeight(.bold).padding()
                LazyVGrid(columns: threeColumnGrid,spacing: 10) {
                    ForEach(shows,id:\.id) { show in
                        NavigationLink(destination: BookSeatView(model: BookSeatModel(movieName: movieServices.selectedMovie?.filmStrTitle ?? "", theatreName: selectedTheatre, show: show))){
                                showDetailView(show: show)
                            
                           
                                           }
                       
                    }.padding()
                    }
            }
            
        }else{
            EmptyView()
        }
       
    }
}

struct showDetailView:View {
    var show:Show
    var body: some View {
        VStack(spacing:10) {
            Text(Common.sharedInstance.getShowTime(time: show.showTime ?? "")).frame(alignment:.center).padding().overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.green, lineWidth: 4)
            )
            Text("\(show.screenStrName ?? "")")

        }
    }
}

//struct BookTicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookTicketView()
//    }
//}
