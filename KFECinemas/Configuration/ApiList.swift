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
   let BASE_URL = "http://202.83.31.153:8075/KFE_Android/save_user_details.php?"

    
        func getUrlString(url: urlString) -> String
        {
            return BASE_URL + url.rawValue
        }
  
}
    
enum urlString: String
{
    case RESTAURANTLIST = "location/"
    case SIGNUP = "registerprocess"
    case LOGIN = "login"
    case SOCIAL_LOGIN = "sociallogin"
    case ORDERHISTORY = "orderhistorys"
    case ORDERDETAIL = "orderdetail"
    case OFFERDETAIL = "apionlinediscount"
    case FORGETPASSWORD = "forgotpasswordapi"
    case ADDADDRESS = "addAddress"
    case GETADDRESS = "getaddAddress"
    case UPDATEADDRESS = "updateaddress"
    case DELETEADDRESS = "deleteaddress"
    case SETPRIMARYADDRESS = "primaryaddress"
    case UPDATEPRIMARYADDRESS = "updateprimaryAddress"
    case APPLY_COUPON = "couponAPI"
    case CUSINEFILTER = "Cuisinefilter"
    case ACCOUNTDETAIL = "userMyaccout"
     case MYACCOUNTPASSWORD =  "myaccountpassword"
    case UPDATEPROFILE = "userupdateAPI"
    case SORTANDFILTER = "filter"
    case ORDERSTATUS = "orderstatus"
    case TRACKORDERS = "ordertracking"
    case UPDATEVERSION = "updateversion"
     case VERSION = "versions"
    case AUTOFILLPOSTCODE = "addresspostcode"
    case FEEDBACK = "feedbackAPI"
    case POSTCODEPAGE = "search-postcode"
    case OPENCLOSE = "opencloseReorder"
    case REPEATORDER = "reorderitems"
    case ADDFAVOURITE = "addfavroitelist"
    case GETFAVOURITE = "favourite"
    case GETOFFERLIST = "couponlist"
    case WALLETBALANCE = "wallet"
    case WALLETHISTORY = "wallet_transaction"
    case WALLETVALIDATE = "walletbutton"
    case SAVECARDS = "savecards"
    case ADDCARDSAVE = "addsavecard"
    case DELETECARD = "deletesavecard"
    case CUSINELISTFILTER = "cuisinelist"
}

