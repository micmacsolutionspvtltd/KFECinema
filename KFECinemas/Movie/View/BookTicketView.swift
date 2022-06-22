//
//  BookTicketView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 09/05/22.
//

import SwiftUI

struct BookTicketView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> 
    @EnvironmentObject var movieServices:MovieServices
    var movie:AllFilms
    @State var selectCurrentDate : Bool = true
    //  @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @State var isActive : Bool = false
    @State var daysOfWeek:[Date] = []
    @State var selectedDate = ""
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack {
                HStack(alignment: .center) {
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                        //  rootPresentationMode.wrappedValue.dismiss()
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
                        DayItemView(date: day , selectedDate: $selectedDate) {
                            let requestModel = ["Date":"\(day.currentDateOnly)","filmcode":"\(movie.filmStrCode ?? "")"]
                            if day.currentDateOnly == Common.sharedInstance.changingDateFormat(date: Date.now , dateFormat : Constants.DateFormat.dateFormatReverse){
                                selectCurrentDate = true
                            }else{
                                selectCurrentDate = false
                            }
                            movieServices.getAllshows(requestBody: requestModel)
                            selectedDate = String(day.currentDayDate)
                        }.frame(maxWidth: .infinity)
                    }
                }
                VStack(alignment:.center){
                    ForEach(movieServices.shows,id:\.id) { shows in
                        
                        showGridView(selectedTheatre:shows.cinemaStrName ?? "", selectedDateCurrent: selectCurrentDate, shows: shows,isActive: self.$isActive )
                    }
                }
                
                
                
                
            }.foregroundColor(.white)
        }.onAppear(perform: {
            movieServices.selectedSeats = []
            let daysOfWeek = Date().daysOfWeek(using: .gregorian)
            selectedDate = String(daysOfWeek[0].currentDayDate)
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
    @Binding var selectedDate : String
    var onclicked:()->()
    
    var body: some View {
        VStack(spacing:10) {
            Text("\(date.currentDay)")
            Text("\(date.currentDayDate)")
          //  if isClicked {
                if selectedDate == "\(date.currentDayDate)"{
                    Divider().frame(width: 30, height: 3).background(Color.red)
                }else{
                    EmptyView()
                }
//            }else{
//                EmptyView()
//            }
        }.onTapGesture {
            isClicked = true
       
            onclicked()
        }
    }
}

struct showGridView:View {
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    var selectedTheatre:String
    var selectedDateCurrent : Bool
    var shows:Shows
    @Binding var isActive : Bool
    @EnvironmentObject var movieServices:MovieServices
    var body: some View {
        if let shows = shows.shows {
            VStack(alignment:.leading){
                Text(selectedTheatre).font(.system(size: 18)).fontWeight(.bold).padding()
                LazyVGrid(columns: threeColumnGrid,spacing: 10) {
                    ForEach(shows,id:\.id) { show in
                        if selectedTheatre == "M1 Cinemas"{
                           if movieServices.cinemaStrid == show.strTicketType{
                        if selectedDateCurrent{
                        if timeValidate(movieTimes: show.showTime ?? ""){
                            NavigationLink(destination: BookSeatView(model: BookSeatModel(movieName: movieServices.selectedMovie?.filmStrTitle ?? "", theatreName: selectedTheatre, show: show))){
                                    showDetailView(show: show)
                                }
                        }
                        }else{
                            NavigationLink(destination: BookSeatView(model: BookSeatModel(movieName: movieServices.selectedMovie?.filmStrTitle ?? "", theatreName: selectedTheatre, show: show))){
                                    showDetailView(show: show)
                                }
                        }
                        }
                        }else{
                            if selectedDateCurrent{
                            if timeValidate(movieTimes: show.showTime ?? ""){
                                NavigationLink(destination: BookSeatView(model: BookSeatModel(movieName: movieServices.selectedMovie?.filmStrTitle ?? "", theatreName: selectedTheatre, show: show))){
                                        showDetailView(show: show)
                                    }
                            }
                            }else{
                                NavigationLink(destination: BookSeatView(model: BookSeatModel(movieName: movieServices.selectedMovie?.filmStrTitle ?? "", theatreName: selectedTheatre, show: show))){
                                        showDetailView(show: show)
                                    }
                            }
                        }
                    }.padding()
                    }
            }
            
        }else{
            EmptyView()
        }
       
    }
    func timeValidate(movieTimes : String) -> Bool{
        if Date().currentTime.compare(movieTimes) == .orderedAscending{
            return true
        }else{
            return false
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
