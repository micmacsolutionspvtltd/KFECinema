//
//  ApiList.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 03/04/22.
//

import Foundation

import UIKit

struct APIList
{
//        let BASE_URL = "http://139.59.70.80/foodapp/public/api/"
//        let BASE_URL = "http://157.245.104.200/foodapp/public/api/"
   
//private final static String BASE_URL = "https://www.dev.fusionkitchen.co.uk";//Live
   let BASE_URL = "http://202.83.31.153:8075/KFE_Android/"

    
        func getUrlString(url: urlString) -> String
        {
            return BASE_URL + url.rawValue
        }
  
}
    
enum urlString: String
{
    case SPICEKITCHEN = "get_food_items_data_categorywise.php"
    case RESTAURANTLIST = "location/"
    case SIGNUP = "save_user_details.php?"
    case LOGIN = "login_valid.php?"
    case FOODLISTAPI = "get_snacks_items_data_theatre_wise.php?"
}

