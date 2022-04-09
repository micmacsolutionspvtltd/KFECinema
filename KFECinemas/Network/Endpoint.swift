//
//  Endpoints.swift
//  FitKet
//
//  Created by Hariharan G on 5/19/20.
//  Copyright © 2020 Fitket. All rights reserved.
//

import UIKit
import SystemConfiguration



var urlType1 = "http://202.83.31.153:8075/"
var urlType2 = "http://202.83.31.153:8077/"

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum Endpoint {
    case login
    case snacksOrderHistory
    case movieBookedOrderHistory
    case foodOrderedHistory
    case movieBookedHistory
    case saveMovieBookingsData
    case selectedPromo
    case resetSeats
    case insertOrderItem
    case insertSnacksOrderItem
    case foodBannerImages
    case bannerImages
    case activeTheatres
    case updatePassword
    case allFilms
    case getAllItems
    case productImages
    case getAllSnacksItems
    case getBannerImages
    case getSnacksItemTheatreWise
    case getFoodItemsCategoryWise
    case getAllFoodBannerImage
    case forgotPasswordGenerateOtp
    case updatePasswordAuthenticatedUsers
    case allFilmsByCinema
    case theaterWiseMovie
    case checkPromoCode
    case saveUserDetails
    case setSeats
    case allShowsByFilm
    case dev
    
    var url:String {
            return tempUrl + "/" + self.path
        }
    
    var tempUrl:String {
        switch self {
        case .login,.snacksOrderHistory,.foodOrderedHistory,.movieBookedHistory,.saveMovieBookingsData,.selectedPromo,.insertOrderItem,.updatePassword,.getAllItems,.getAllSnacksItems,.getBannerImages,.getSnacksItemTheatreWise,.getFoodItemsCategoryWise,.getAllFoodBannerImage,.forgotPasswordGenerateOtp,.updatePasswordAuthenticatedUsers,.checkPromoCode,.saveUserDetails,.movieBookedOrderHistory,.insertSnacksOrderItem: return urlType1
        case .resetSeats,.foodBannerImages,.bannerImages,.activeTheatres,.allFilms,.productImages,.allFilmsByCinema,.theaterWiseMovie,.setSeats,.allShowsByFilm,.dev: return urlType2
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "KFE_Android/login_valid.php"
        case .snacksOrderHistory:
            return "KFE_Android/snacks_ordered_history.php"
        case .movieBookedOrderHistory:
            return "KFE_Android/movie_booked_history.php"
        case .foodOrderedHistory:
            return "KFE_Android/food_ordered_history.php"
        case .movieBookedHistory:
            return "KFE_Android/movie_booked_history.php"
        case .saveMovieBookingsData:
            return "KFE_Android/save_movie_bookings_data.php"
        case .selectedPromo:
            return "KFE_Android/calculate_discount_for_selected_promo.php"
        case .resetSeats:
            return "api/kfecinema/resetseats"
        case.insertOrderItem:
            return "KFE_Android/insert_ordered_item.php"
        case .insertSnacksOrderItem:
            return "KFE_Android/insert_snacks_ordered_items.php"
        case .foodBannerImages:
            return "KFE_4/public/kfe_food_banner_images/"
        case .bannerImages:
            return "KFE_4/public/kfe_banner_images/"
        case .activeTheatres:
            return "api/kfecinema/Active_Theaters"
        case .updatePassword:
            return "KFE_Android/update_password.php"
        case .allFilms:
            return "api/KfeCinema/allfilms"
        case .getAllItems:
            return "KFE_Android/get_all_items.php/"
        case .productImages:
            return "KFE_4/public/kfe_product_images/"
        case .getAllSnacksItems:
            return "KFE_Android/get_all_snacks_items.php/"
        case .getBannerImages:
            return "KFE_Android/get_banner_images.php/"
        case .getSnacksItemTheatreWise:
            return "KFE_Android/get_snacks_items_data_theatre_wise.php?theatre_id=2"
        case .getFoodItemsCategoryWise:
            return "KFE_Android/get_food_items_data_categorywise.php"
        case .getAllFoodBannerImage:
            return "KFE_Android/get_all_food_banner_image.php"
        case .forgotPasswordGenerateOtp:
            return "KFE_Android/forgot_password_generate_otp.php"
        case .updatePasswordAuthenticatedUsers:
            return "KFE_Android/update_password_for_otp_authenticated_users.php"
        case .allFilmsByCinema:
            return "api/KfeCinema/allfilmsbycinema"
        case .theaterWiseMovie:
            return "api/KfeCinema/TheaterwiseMovie"
        case .checkPromoCode:
            return "KFE_Android/check_promocode_availability.php"
        case .saveUserDetails:
            return "KFE_Android/save_user_details.php"
        case .setSeats:
            return "api/kfecinema/setseats"
        case .allShowsByFilm:
            return "api/kfecinema/allShowsbyfilm"
        case .dev:
            return "api/kfecinema/dev"
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .saveMovieBookingsData,.selectedPromo,.resetSeats,.insertOrderItem,.insertSnacksOrderItem,.activeTheatres,.updatePassword,.allFilms,.getAllFoodBannerImage,.getSnacksItemTheatreWise,.forgotPasswordGenerateOtp,.allFilmsByCinema,.theaterWiseMovie,.checkPromoCode,.saveUserDetails,.setSeats,.allShowsByFilm,.dev: return .post
        case .login,.snacksOrderHistory,.movieBookedHistory,.foodOrderedHistory,.movieBookedOrderHistory,.foodBannerImages,.bannerImages,.getAllItems,.productImages,.getAllSnacksItems,.getBannerImages,.getFoodItemsCategoryWise,.updatePasswordAuthenticatedUsers: return .get
        
        }
    }
}
