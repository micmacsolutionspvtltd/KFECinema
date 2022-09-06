//
//  DashboardServices.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 06/04/22.
//

import Foundation

class DashboardServices:ObservableObject {
    
     var initialAllFilms:[AllFilms] = []
     var initialSpiceKitchenItems:[SpiceKitchen] = []
     var initialConcessionZoneItems:[ConcessionZoneItem] = []
     var initialActiveTheatres:[Theatre] = []
     var initialSpiceCinemas : [AllFilms] = []
     var initialMoneCinemas  : [AllFilms] = []
    var initialUpcomingMovies : [AllFilms] = []
    var initialSpiceImageData : [GetFinalDataImage] = []
    var initialMoneImageData : [GetFinalDataImage] = []
    var initialUpcomingImageData : [GetFinalDataImage] = []
    var initialSpiceFoodData : [NewConceesionData] = []
     var initialMoneFoodData : [NewConceesionData] = []
    
    
    @Published var bannerImages:[BannerModel] = []
    @Published var allFilms:[AllFilms] = []
    @Published var spiceKitchenItems:[SpiceKitchen] = []
    @Published var concessionZoneItems:[ConcessionZoneItem] = []
    @Published var activeTheatres:[Theatre] = []
    @Published var spiceCinemas : [AllFilms] = []
    @Published var moneCinemas  : [AllFilms] = []
    @Published var upcomingMovies  : [AllFilms] = []
    @Published var finalSpiceImageData : [GetFinalDataImage] = []
    @Published var finalMoneImageData : [GetFinalDataImage] = []
    @Published var finalUpcomingImageData : [GetFinalDataImage] = []
    @Published var newSpiceZoneData : [NewConceesionData] = []
    @Published var newMoneZoneData : [NewConceesionData] = []
    @Published var finalSpiceZoneData : [NewConceesionData] = []
    @Published var finalFoodImageData : [GetFinalDataImage] = []
    @Published var spiceCienmasID = ""
    @Published var spiceMovieName = ""
    @Published var moneCienmasID = ""
    @Published var moneMovieName = ""
    @Published var upComingMoviesID = ""
    @Published var upcomingMovieName = ""
    @Published var spiceFoodId = ""
    @Published var spiceFoodName = ""
    @Published var moneFoodId = ""
    @Published var moneFoodName = ""
    
    func getAllBannerImages(completionHandler : @escaping ([BannerModel]) -> Void){
    
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getBannerImages))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BannerResponseModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    bannerImages = result?.banners ?? []
                    completionHandler(result?.banners ?? [])
                }else{
                    
                }
               
           
            }
        }
        
    }
    
    func getAllFilms(completionHandler : @escaping([AllFilms]) -> Void){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.allFilms))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: AllFilmsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    initialAllFilms = result?.data ?? []
                    allFilms = result?.data ?? []
                    completionHandler(result?.data ?? [])
                }else{
                    
                }
               
           
            }
        }
    }
    func getUpcomingMovies(completionHandler : @escaping(String) -> Void){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.upComingMovies))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: AllFilmsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    for i in (result?.data ?? []){
                        upComingMoviesID += "\(i.filmStrCode ?? ""),"
                        upcomingMovieName += "\(i.filmStrTitle ?? ""),"
                    }
                    upComingMoviesID = String(upComingMoviesID.dropLast())
                    upcomingMovieName = String(upcomingMovieName.dropLast())
                    initialUpcomingMovies = result?.data ?? []
                    upcomingMovies = result?.data ?? []
                    completionHandler("")
                }else{
                    
                }
               
           
            }
        }
    }
    func getParticularCinemaApi(cinemaCode : String , completionHandler : @escaping(String) -> Void){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.allFilmsByCinema ,  requestBody : ["cinemacode" : cinemaCode]))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: AllFilmsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    if cinemaCode == "0002"{
                        for i in (result?.data ?? []){
                            spiceCienmasID += "\(i.filmStrCode ?? ""),"
                            spiceMovieName += "\(i.filmStrTitle ?? ""),"
                        }
                        spiceCienmasID = String(spiceCienmasID.dropLast())
                        spiceMovieName = String(spiceMovieName.dropLast())
                        initialSpiceCinemas = result?.data ?? []
                        spiceCinemas = result?.data ?? []
                        
                        completionHandler("")
                    }else{
                        for i in (result?.data ?? []){
                            moneCienmasID += "\(i.filmStrCode ?? ""),"
                            moneMovieName += "\(i.filmStrTitle ?? ""),"
                        }
                        moneCienmasID = String(moneCienmasID.dropLast())
                        moneMovieName = String(moneMovieName.dropLast())
                        initialMoneCinemas = result?.data ?? []
                        moneCinemas = result?.data ?? []
                        completionHandler("")
                    }
                  
                }else{
                    
                }
               
           
            }
        }
    }
    
    func getAllSpiceKitchenItems(){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getAllItems))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: SpiceKitchenResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    initialSpiceKitchenItems = result?.data ?? []
                    spiceKitchenItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func getConcessionZoneItems(){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getAllSnacksItems))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ConcessionZoneResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    initialConcessionZoneItems = result?.data ?? []
                    concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
 

    
    func getAllActiveTheatres(){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.activeTheatres))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ActiveTheatreResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    
                    initialActiveTheatres = result?.data ?? []
                    activeTheatres = result?.data ?? []
              //      concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func searhFilter(text:String){
        
        if text.count > 0 {
            finalSpiceImageData = initialSpiceImageData.filter { value in
                value.name!.lowercased().contains(text.lowercased())
            }
            finalMoneImageData = initialMoneImageData.filter { value in
                value.name!.lowercased().contains(text.lowercased())
            }
            finalUpcomingImageData = initialUpcomingImageData.filter { value in
                value.name!.lowercased().contains(text.lowercased())
            }
            allFilms = initialAllFilms.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            
            spiceKitchenItems = initialSpiceKitchenItems.filter { value in
                value.itemInfo!.itemName!.lowercased().contains(text.lowercased())
            }
            concessionZoneItems = initialConcessionZoneItems.filter { value in
                value.itemInfo!.itemName!.lowercased().contains(text.lowercased())
            }
            activeTheatres = initialActiveTheatres.filter { value in
                value.cinemaStrName!.lowercased().contains(text.lowercased())
            }
            spiceCinemas = initialSpiceCinemas.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            moneCinemas = initialMoneCinemas.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            upcomingMovies = initialUpcomingMovies.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            newSpiceZoneData = initialSpiceFoodData.filter { value in
                value.itemStrDescription!.lowercased().contains(text.lowercased())
            }
            newMoneZoneData = initialMoneFoodData.filter { value in
                value.itemStrDescription!.lowercased().contains(text.lowercased())
            }
        } else{
           finalSpiceImageData = initialSpiceImageData
            finalMoneImageData = initialMoneImageData
            finalUpcomingImageData = initialUpcomingImageData
            allFilms = initialAllFilms
            spiceKitchenItems = initialSpiceKitchenItems
            concessionZoneItems = initialConcessionZoneItems
            activeTheatres = initialActiveTheatres
            spiceCinemas = initialSpiceCinemas
            moneCinemas = initialMoneCinemas
            upcomingMovies = initialUpcomingMovies
            newSpiceZoneData = initialSpiceFoodData
            newMoneZoneData = initialMoneFoodData
        }
    
     
        
    }
                    
    func changePassWordApi(newPassword : String ,oldPassword : String , completionHandler : @escaping (PromoCheckModel) -> Void){
     //   let params : [String : String]
        let params : [String : String] = [
            "new_password":newPassword,
            "old_password" : oldPassword,
            "user_id" : StorageSettings().userId
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.updatePassword , requestBody : params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: PromoCheckModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    completionHandler(result!)
              //      concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func postMovieDetail(movieId : String , movieName : String){
        let params : [String : String]?
      params = [
        "movie_id": movieId,
        "movie_name": movieName
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.postMovieDetail,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: GetFinalImageModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{

            }else{
             
            }
            }
        }
        
    }
    func getNewConcessionZoneApi(cinemaCode : String , completionHandler : @escaping(String) -> Void){   
        let Url = String(format: APIList().getUrlTypeTwo(url: .NEWSPICEKITCHENAPI))
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["cinemacode": cinemaCode]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            DispatchQueue.main.async {
            if let data = data {
                do {
                    let gitData = try JSONDecoder().decode(NewConceesionModel.self, from: data)
                    if cinemaCode == "0002"{
                        for i in (gitData.data ?? []){
                            self.spiceFoodId += "\(i.itemStrID ?? ""),"
                            self.spiceFoodName += "\(i.itemStrDescription ?? ""),"
                        }
                        self.spiceFoodId = String(self.spiceFoodId.dropLast())
                        self.spiceFoodName = String(self.spiceFoodName.dropLast())
                        self.initialSpiceFoodData = gitData.data ?? []
                        self.newSpiceZoneData = gitData.data ?? []
                        completionHandler("")
                    }else{
                        for i in (gitData.data ?? []){
                            self.moneFoodId += "\(i.itemStrID ?? ""),"
                            self.moneFoodName += "\(i.itemStrDescription ?? ""),"
                        }
                        self.moneFoodId = String(self.moneFoodId.dropLast())
                        self.moneFoodName = String(self.moneFoodName.dropLast())
                        self.initialMoneFoodData = gitData.data ?? []
                        self.newMoneZoneData = gitData.data ?? []
                        completionHandler("")
                    }
                } catch {
                    print(error)
                }
            }
        }
        }.resume()
    }
    
    func postImageDetail(foodId : String , foodName : String , cinemaCode : String){
        let params : [String : String]?
      params = [
        "food_id": foodId,
        "food_name": foodName
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.postImageDetail,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: GetFinalImageModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                if cinemaCode == "0002"{
                    for i in 0..<(result?.data?.count ?? 0){
                        if result?.data?[i].image == "" || result?.data?[i].image == nil{
                            self.newSpiceZoneData[i].image = ""
                        }else{
                            self.newSpiceZoneData[i].image = result?.data?[i].image ?? ""
                        }
                        
                    }
                    self.finalFoodImageData = result?.data ?? []
                    self.initialSpiceFoodData = self.newSpiceZoneData
                }else{
                    for i in 0..<(result?.data?.count ?? 0){
                        if result?.data?[i].image == "" || result?.data?[i].image == nil{
                            self.newMoneZoneData[i].image = ""
                        }else{
                            self.newMoneZoneData[i].image = result?.data?[i].image ?? ""
                        }
                        
                    }
                }
            }else{
             
            }
            }
        }
        
    }
    
    func getFinalCiemasApi(movieId : String , theaterId : String , movieName : String){
        let params : [String : String]?
        params = [
            "movie_id": movieId ,
            "movie_name" : movieName
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getFinalMovieImage,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: GetFinalImageModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
                if restValue == true{
                    if theaterId == "0002"{
                        self.initialSpiceImageData = result?.data ?? []
                        self.finalSpiceImageData = result?.data ?? []
                    }else if theaterId == "0003"{
                        self.initialMoneImageData = result?.data ?? []
                        self.finalMoneImageData = result?.data ?? []
                    }else{
                        self.initialUpcomingImageData = result?.data ?? []
                        self.finalUpcomingImageData = result?.data ?? []
                    }
                }else{
                    
                }
            }
        }
        
    }
}
