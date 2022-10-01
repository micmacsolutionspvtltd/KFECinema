//
//  MovieDetailView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 03/04/22.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> 

    @State var showingAlert = false
    @State private var isActive : Bool = false
    var movie:AllFilms
    @State var imageData : GetFinalDataImage
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack {
                HStack(alignment: .top) {
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                       // rootPresentationMode.wrappedValue.dismiss()
                    }){
                        
                        Image(systemName:  "arrow.left").foregroundColor(.white).padding()
                    }
                    Spacer()
                    MoviesDetailImageView(withURL: Endpoint.showMovieImage.url + (imageData.image ?? "")).frame(width: 180, height: 260)
                    Spacer()
                    
                }
                .padding()
            }
            VStack(spacing:5){
                HStack() {
                    Text("\(movie.filmStrTitle ?? "")").foregroundColor(.white)
                    Divider().background(.white).frame(height:30)
                    Text("\(movie.filmStrShortNameAlt ?? "")").foregroundColor(.white)
                    Spacer().frame(width: 5)
                    if movie.filmStrCensor == "A"{
                        Text( "\(movie.filmStrCensor ?? "")").foregroundColor(.white).opacity(0.7).minimumScaleFactor(0.4).font(.system(size: 13,weight: .bold)).frame(width : 20, height:20).background(Color.red).cornerRadius(20)
                    }else{
                        Text( "\(movie.filmStrCensor ?? "")").foregroundColor(.black).opacity(0.7).minimumScaleFactor(0.4).font(.system(size: 13,weight: .bold)).frame(width : 20, height:20).background(Color.white).cornerRadius(20)
                    }
                    Spacer()
                }
                HStack {
                    Text("\(movie.filmCatStrName ?? "")").fontWeight(.semibold).foregroundColor(.blue)
                    Spacer()
                }
                
                HStack {
                    Image(systemName:  "clock.fill").foregroundColor(.white)
                    Text("\(movie.filmIntDuration ?? 0) mins").foregroundColor(.white).font(.system(size: 15))
                    Spacer()
                }
            }.padding(.leading,20)
           
            Divider().background(.white).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            VStack(alignment:.leading,spacing: 10) {
                Text("Storyline").padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)).foregroundColor(.white).font(.system(size: 14)).background(Color(hue: 1.0, saturation: 0.081, brightness: 0.866)).cornerRadius(5)
                Text("\(movie.filmStrDescription ?? "")")
                    .foregroundColor(Color.white).font(.system(size: 14))
                Text("CAST OVERVIEW").fontWeight(.bold).foregroundColor(.white).font(.system(size: 16))
                Text("\(movie.filmStrContent ?? "")")
                    .foregroundColor(Color.white).font(.system(size: 14))
                Text("Director").fontWeight(.bold).foregroundColor(.white).font(.system(size: 15))
                Text("White walker")
                    .foregroundColor(Color.white).font(.system(size: 14))
            }.padding(.leading,20).padding(.bottom,20)
            Spacer()
         //   if movie.filmStrCensor == "U"{
                Button(action: {
                    if movie.filmStrCensor == "A"{
                        showingAlert = true
                    }else{
                        isActive = true
                    }
                    
                }){
                    Text("BOOK TICKET").padding().frame(maxWidth: .infinity).background(.red)
                }
//            }else{
//            NavigationLink(isActive : self.$isActive){
//                BookTicketView(movie: movie)
//            }label: {
//                Text("BOOK TICKET").padding().frame(maxWidth: .infinity).background(.red)
//            }.isDetailLink(false).navigationViewStyle(.stack)
//            }
        }
                .background(Color("ColorAppGrey")).ignoresSafeArea().navigationBarHidden(true)
            .overlay(VStack {
                if isActive {
                    NavigationLink(destination: BookTicketView(movie: movie), isActive: $isActive) {
                        
//                                        (viewModel.getTicketHistoryData?.data?[finalValues] ?? [])
                    }.isDetailLink(false).opacity(0)
                        .background(Color.red)
                    
                }
            })
            .alert(isPresented: $showingAlert){
                Alert(
                    title: Text(""),
                    message: Text("This movie has been rated \(String("A")) and is for audiences above the age of 18.Please carry a valid photo ID and age proof to the theatre. No refund of tickets once bought.").fontWeight(.bold),
                    primaryButton: .default(Text("Accept"), action: {
                        self.isActive = true
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: { // 1
                        showingAlert = false
                        
                    })
                )
            }
        

    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
