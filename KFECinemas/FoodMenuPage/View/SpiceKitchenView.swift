

//
//  SpiceKitchenView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//
import SwiftUI

struct SpiceKitchenView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) var rootPresentationMode: Binding<RootPresentationMode>
    @State private var isActive : Bool = false
    
    @State var bannerImageData: FoodBannerImageModel?
    @State var getConcessionData : FoodListModel?
    @State var getSpiceKitchenData: SpiceKitchenModel?
    @State var concessionZoneData : [NewConceesionData] = []
    @State var pageName : String = "Spice Kitchen"
    var lastPage : String? = ""
    @State var vegClicked : Bool = false
    var lastPagName : String? = ""
    @ObservedObject var viewModel = FoodListViewModel()
    @EnvironmentObject var movieServices:MovieServices
    @EnvironmentObject var dashBoardViewModel:DashboardServices
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    @State var showingAlert = false
    @State var moveNextPage : Bool = false
    @State var showLoader : Bool = true
    var theaterID : String = "8"
    var theaterName : String = "M1 Cinemas"
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ScrollView {
                    VStack{
                        VStack{
                            ScrollView{
                                VStack(spacing : 0){
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
                                                Button{
                                                    if lastPage == "bookSeatView"{
                                                        showingAlert = true
                                                    }else{
                                                        dashBoardViewModel.searhFilter(text: "")
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
                                    
                                    
                                }
                                ScrollViewReader { scrollView in
                                    ScrollView(.horizontal) {
                                        LazyHStack {
                                            ForEach(bannerImageData?.data ?? [], id: \.id) { banner in
                                                let url = Endpoint.foodBannerImages.url + (banner.foodImageURL ?? "")
                                                BannerImageView(withURL: url)
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                if pageName != "Spice Kitchen"{
                                    HStack {
                                        
                                        TextField("", text: $searchText).onChange(of: searchText, perform: { newValue in
                                            print(newValue)
                                            self.searhFilter(text: newValue)
                                            
//                                            if theaterID == "0002"{
//                                                concessionZoneData = dashBoardViewModel.newSpiceZoneData
//                                            }else{
//                                                concessionZoneData = dashBoardViewModel.newMoneZoneData
//                                            }
                                        }).placeholder(when: searchText.isEmpty) {
                                            Text("Search food or snacks").foregroundColor(.white).opacity(0.4)
                                        }.disableAutocorrection(true)
                                            .foregroundColor(.white)
                                            .accentColor(Color.white)
                                        
                                        
                                        
                                        Button(action:{
                                            
                                        }){
                                            
                                            Image(systemName:  "magnifyingglass").foregroundColor(.white)
                                        }
                                    }.padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: .infinity)
                                                .stroke(Color.red, lineWidth: 2.0)
                                        ).padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 20)).background(Color.black)
                                }
                                if pageName == "Spice Kitchen"{
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
                                                                    VegItemsOnlyShow(foodDatas: rowData)
                                                                }else{
                                                                    DishViewCell(textContent: rowData.itemName ?? "", amount: rowData.price ?? "", images: rowData.image ?? "",buttonTittle : rowData.categoryName ?? "",allRowData : rowData,getDataValue :({
                                                                    }) )
                                                                    .listStyle(.sidebar).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                                                    .background(Color.white).cornerRadius(7)
                                                                }
                                                            }
                                                        }.foregroundColor(.white)
                                                    }
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity).edgesIgnoringSafeArea(.all)
                                        .accentColor(.white)
                                        .listStyle(.sidebar)
                                        .background(Color.black)
                                        .frame(height: geometry.size.height-50)
                                    }else{
                                        List{
                                            ForEach(concessionZoneData  , id : \.self){ foodData in
                                                ConcessionZoneCell(model: foodData) {
                                                    
                                                }.frame(maxWidth: .infinity)
                                                    .padding(10)
                                                    .background(RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color.black)
                                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1))
                                            }
                                        }.listStyle(PlainListStyle())
                                        
                                        //                                        List{
                                        //                                            ForEach(getConcessionData?.data ?? [] , id :\.self){ sectionData in
                                        //                                                if let itemDatas = sectionData.items{
                                        //                                                    if itemDatas.count != 0{
                                        //                                                        Section(header : Text(sectionData.categoryName ?? "")) {
                                        //                                                            ForEach(sectionData.items ?? [] , id : \.self){ rowData in
                                        //                                                                if vegClicked{
                                        //                                                                    VegItemsOnlyShow(foodDatas: rowData)
                                        //                                                                }else{
                                        //                                                                    DishViewCell(textContent: rowData.itemName ?? "", amount: rowData.price ?? "", images: rowData.image ?? "",buttonTittle : rowData.categoryName ?? "",allRowData : rowData,getDataValue :({
                                        //
                                        //                                                                    }) )
                                        //
                                        //                                                                    .listStyle(.sidebar).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                        //                                                                    .background(Color.white).cornerRadius(7)
                                        //                                                                }
                                        //
                                        //
                                        //                                                            }
                                        //                                                        }.foregroundColor(.white)
                                        //                                                    }
                                        //                                                }
                                        //
                                        //                                            }
                                        //                                        }
                                            .frame(maxWidth: .infinity).edgesIgnoringSafeArea(.all)
                                        
                                        // .accentColor(.white)
                                        //.listStyle(.)
                                        // .background(Color.black)
                                            .frame(height: geometry.size.height-50)
                                    }
                                    
                                } else {
                                    // Fallback on earlier versions
                                }
                            }
                        }
                        
                    }
                    
                }
                
                if storeDataViewModel.items.count == 0{
              //      dashBoardViewModel.searhFilter(text: "")
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
                        }//.isDetailLink(false)
                            .position(x: geometry.size.width/2, y: geometry.size.height/1.05)
                    }
                }else{
                    NavigationLink()
                    {
                        if lastPage == ""{
                            CartPageView(pageNames : pageName , selectedTheaterName : theaterName, theaterId  : theaterID)
                            
                        }else{
                            CheckoutView()
                        }
                    } label: {
                        HStack(spacing :20){
                            Text("\(storeDataViewModel.calculateTotalQuantity()) Items")
                            //.fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 100)
                            Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                                .frame(height: 100)
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
                    }//.isDetailLink(false)
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.05)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true).navigationViewStyle(.stack)
            .loaderView(isShowing: $showLoader)
            .onAppear(){
                
                storeDataViewModel.deleteAllDatas()
                viewModel.getAllBannerImages{ result in
                    bannerImageData = result
                }
                if pageName == "Spice Kitchen"{
                    
                    viewModel.spiceKitchenValueGetApi{ result in
                        showLoader = false
                        getSpiceKitchenData = result
                    }
                    
                }else{
                    if theaterID == "0002"{
                        concessionZoneData = dashBoardViewModel.newSpiceZoneData
                    }else{
                        concessionZoneData = dashBoardViewModel.newMoneZoneData
                    }
                    showLoader = false
                }
                
            }.background(Color("ColorAppGrey"))
                .onWillDisappear(){
                    dashBoardViewModel.searhFilter(text: "")
                }
             
        }.alert(isPresented: $showingAlert){
            Alert(
                title: Text("CONFIRMATION"),
                message: Text("Do you want to end the session"),
                primaryButton: .default(Text("Yes"), action: {
                    dashBoardViewModel.searhFilter(text: "")
                    storeDataViewModel.deleteAllDatas()
                    resetSeatMultipleSeats()
                    NavigationUtil.popToRootView()
                    rootPresentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel(Text("Cancel"), action: { // 1
                    showingAlert = false
                    
                })
            )
        }
        
    }
    func searhFilter(text:String){
        
        if text.count > 0 {
            if theaterID == "0002"{
                concessionZoneData = dashBoardViewModel.initialSpiceFoodData.filter { value in
                    value.itemStrDescription!.lowercased().contains(text.lowercased())
                }
            }else{
                concessionZoneData = dashBoardViewModel.initialMoneFoodData.filter { value in
                    value.itemStrDescription!.lowercased().contains(text.lowercased())
                }
            }
//            newSpiceZoneData = initialSpiceFoodData.filter { value in
//                value.itemStrDescription!.lowercased().contains(text.lowercased())
//            }
//            newMoneZoneData = initialMoneFoodData.filter { value in
//                value.itemStrDescription!.lowercased().contains(text.lowercased())
//            }
        } else{
            if theaterID == "0002"{
                concessionZoneData = dashBoardViewModel.initialSpiceFoodData
            }else{
                concessionZoneData = dashBoardViewModel.initialMoneFoodData
            }
            
            
        }
    
     
        
    }
    func resetSeatMultipleSeats(){
        
        let filteredArray = movieServices.selectedSeats.filter { value in
            movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransId ?? "")"])
            return false
        }
        movieServices.selectedSeats = []
    }
}

struct SpiceKitchenView_Previews: PreviewProvider {
    static var previews: some View {
        SpiceKitchenView()
    }
}



struct VegItemsOnlyShow:View {
    var foodDatas:ItemInfo
    // @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    
    var body: some View {
        if foodDatas.categoryName == "Veg"{
            
            DishViewCell(textContent: foodDatas.itemName ?? "", amount: foodDatas.price ?? "", images: foodDatas.image ?? "",buttonTittle : foodDatas.categoryName ?? "",allRowData : foodDatas,getDataValue :({
            }) )
            .listStyle(.sidebar).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            .background(Color.white).cornerRadius(7)
            
            
        }
    }
    
}
