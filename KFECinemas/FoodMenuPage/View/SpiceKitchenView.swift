
     
//
//  SpiceKitchenView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//
import SwiftUI

struct SpiceKitchenView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var bannerImageData: FoodBannerImageModel?
    @State var getConcessionData : FoodListModel?
    @State var getSpiceKitchenData: SpiceKitchenModel?
    @State var pageName : String = "Spice Kitchen"
    @State var lastPage : String? = ""
    @State var vegClicked : Bool = false
    var lastPagName : String? = ""
    @ObservedObject var viewModel = FoodListViewModel()
    @EnvironmentObject var movieServices:MovieServices
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel

    @State var getCartDatas : Bool? = false
    @State var showingAlert = false
    @State var moveNextPage : Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack{
              ScrollView {
                VStack{
                    VStack{
                    ScrollView{
                   
                    ZStack{
                        Text(pageName)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .accentColor(Color.white)
                        HStack{
                            HStack(alignment: .bottom ){
                               // NavigationLink{
                                Button{
                                  //  Dashboard()
                                    if lastPage == "bookSeatView"{
                                        showingAlert = true
                                    }else{
                                        storeDataViewModel.deleteAllDatas()
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                    
                                }label: {
                                    
                                    
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25.0, height: 25.0)
                                        .foregroundColor(.white)
                                    
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 20, trailing: 20))
                    .frame(minWidth: geometry.size.width,maxHeight: 60)
                    .background(Color.red)
                    //   HStack{
                    ScrollViewReader { scrollView in
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(viewModel.getBannerImageData?.data ?? [], id: \.id) { banner in
                               // ForEach(0..<5) { banner in
                                    let url = Endpoint.foodBannerImages.url + (banner.foodImageURL ?? "")
                                    BannerImageView(withURL: url)
                                    //    .cornerRadius(10)
                                      //  .frame(height: 100)
                                }
                            }
                            .onAppear {
                                viewModel.getAllBannerImages{ result in
                                    bannerImageData = result
                                }
                                // scrollView.scrollTo(movieNotes[movieNotes.endIndex - 1])
                            }
                        }
                    }
                    HStack{
                        Spacer()
                        Button {
                            if vegClicked{
                               vegClicked = false
                            }else{
                               vegClicked = true
                            }
                        } label: {
                            HStack{
                                Text("Veg")
                                    .foregroundColor(.white)
                                
                                Image(systemName: "circle.circle.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.green)
                                    .background(Color.white)
                                if vegClicked{
                                    Text("X")
                                 .foregroundColor(.white)
                                }else{
                               //  Spacer()
                                }
                                
                            }.frame(width: 120)
                                .padding()
                                .background(vegClicked ? Color.gray : Color.black)
                                .cornerRadius(.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: .infinity)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                               
                            
                            
                            
                        }
                        
                    }
                }
                }
                    ZStack{
                        Color.black
                            .edgesIgnoringSafeArea(.all)
                    VStack{
                    if #available(iOS 14.0, *) {
                        if pageName == "Spice Kitchen"{
                            List{
                                ForEach(getSpiceKitchenData ?? [] , id :\.self){ sectionData in
                                    if let itemDatas = sectionData.itemsInfo {
                                        if itemDatas.count != 0{
                                            Section(header : Text(sectionData.subCatName ?? "")) {
                                                ForEach(sectionData.itemsInfo ?? [] , id : \.self){ rowData in
                                                    if vegClicked{
                                                        //print(rowData.categoryName ?? "")
                                                        DishViewCell(textContent: rowData.itemName ?? "", amount: rowData.price ?? "", images: rowData.image ?? "",buttonTittle : rowData.categoryName ?? "",allRowData : rowData,getDataValue :({
                                                   //         dbViewModel.getAllDataFromTable()
                                                        }) )
                                                            .frame(width: geometry.size.width*0.8,height: 100)
                                                        //    .padding(10)
                                                            .padding([.leading,.trailing],10)
                                                            .background(Color.black)
                                                            .cornerRadius(10)
                                                    }else{
                                                    Text("Item")
                                                            .foregroundColor(Color.black)
                                                        DishViewCell(textContent: rowData.itemName ?? "", amount: rowData.price ?? "", images: rowData.image ?? "",buttonTittle : rowData.categoryName ?? "",allRowData : rowData,getDataValue :({
                                                    //        dbViewModel.getAllDataFromTable()
                                                        }) ) //.listRowBackground(.black)
                                                        .listStyle(.sidebar)
                                                        .background(Color.black)
                                                    }
                                                
                                                }
                                        
                                                //.listRowBackground(Color.black)
                                            }.foregroundColor(.white)
                                        }
                                    }
                                
                                  //  }
                               
                                }
                            }//.listStyle(.sidebar)
                            .frame(maxWidth: .infinity).edgesIgnoringSafeArea(.all)
                            .accentColor(.white)
                            .listStyle(.sidebar)
                            .background(Color.black)
                            .frame(height: geometry.size.height-50)
                        }else{
                            List{
                                ForEach(getConcessionData?.data ?? [] , id :\.self){ sectionData in
                                   // if sectionData.items.count !=0
                                    if let itemDatas = sectionData.items{
                                      if itemDatas.count != 0{
                                            Section(header : Text(sectionData.categoryName ?? "")) {
                                                ForEach(sectionData.items ?? [] , id : \.self){ rowData in
                                                    if vegClicked{
//                                                        if rowData.categoryName == "Veg"{
//                                                            Text("Items")
//                                                        }
//                                                        if rowData.categoryName == ""{
//
//                                                        }
                                                     //   print(rowData.categoryName!)
                                                    }else{
                                                        DishViewCell(textContent: rowData.itemName ?? "", amount: rowData.price ?? "", images: rowData.image ?? "",buttonTittle : rowData.categoryName ?? "",allRowData : rowData,getDataValue :({
                                           //                 dbViewModel.getAllDataFromTable()
                                                            
                                                        }) )
                                                        
                                                        .listStyle(.sidebar).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                                        .background(Color.black).cornerRadius(7)
                                                    }
                                                    
                                                    
                                                }
                                            }.foregroundColor(.white)
                                        }
                                   }
                         
                                }
                            }//.listStyle(.sidebar)
                            //                   // }
                            .frame(maxWidth: .infinity).edgesIgnoringSafeArea(.all)
                            
                            .accentColor(.white)
                            .listStyle(.sidebar)
                            .background(Color.black)
                            .frame(height: geometry.size.height-50)
                        }
                        
                        // .listStyle(GroupedListStyle())
                    } else {
                        // Fallback on earlier versions
                    }
                }
                }
                    
                }
                    
            }
                
                if storeDataViewModel.items.count == 0{
                    if lastPage != ""{
                    NavigationLink{
                        CheckoutView()
                    }label : {
                        HStack{
                            Text("SKIP")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                               
                        } .frame(maxWidth: .infinity)
                            .frame(height : 25)
                      
                            .padding(.vertical , 15)
                            .padding(.horizontal, -15)
                            
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.1)
                    }
                }else{
                    NavigationLink{
                        if lastPage == ""{
                            CartPageView(pageNames : pageName)

                        }else{
                            CheckoutView()
                        }
                    } label: {
                        HStack(spacing :20){
                            Text("\(storeDataViewModel.items.count) Items")
                            //.fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 100)
                            Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                                .frame(height: 100)
//                            Spacer()
                            Text("ADD")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 10)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(.infinity)
//
                            
                       }
                        .frame(maxWidth: .infinity)
                        .frame(height : 25)
                  
                        .padding(.vertical , 15)
                        .padding(.horizontal, -15)
                        
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.1)
            }
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            // .background(Color.black)
        
            .onAppear(){
              //  dbViewModel.getAllDataFromTable()
               // viewModel.getApiData()
                if pageName == "Spice Kitchen"{
                    
                    viewModel.spiceKitchenValueGetApi{ result in
                        getSpiceKitchenData = result
                    }
                    
                }else{
                    viewModel.fooddListValueShowApi { result in
                        getConcessionData = result
                    }
                }
                
            }.background(Color("ColorAppGrey"))
        }.alert(isPresented: $showingAlert){
        
            Alert(
                title: Text("CONFIRMATION"),
                message: Text("Do you want to end the session"),
                primaryButton: .default(Text("Yes"), action: {
                    storeDataViewModel.deleteAllDatas()
                    resetSeatMultipleSeats()
                    moveNextPage = true
                }),
                secondaryButton: .cancel(Text("Cancel"), action: { // 1
                    showingAlert = false
                    
                })
            )
        }
        NavigationLink(destination: Dashboard(), isActive: $moveNextPage){
       
        }
    }
    func resetSeatMultipleSeats(){
        
            let filteredArray = movieServices.selectedSeats.filter { value in
              //  if value.strTransId != nil{
                    movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransId ?? "")"])
                    return false
             //   }
          
            }
            movieServices.selectedSeats = []
      //  }
       
    }
}

struct SpiceKitchenView_Previews: PreviewProvider {
    static var previews: some View {
        SpiceKitchenView()
    }
}

