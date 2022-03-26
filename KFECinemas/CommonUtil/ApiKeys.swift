//
//  ApiKeys.swift
//  Basispay QR
//
//  Created by Saravanan on 20/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct ApiKeys {
    static let userId = "userId"
    struct OtpKeys{
        static let mobileNumber = "mobileNumber"
        static let userName = "userName"
        static let otp = "otp"
        static let deviceToken = "deviceToken"
    }

    struct GroupKeys {
        
        static let groupName = "groupName"
        static let userGroupId = "userGroupId"
        static let isDelete = "isDelete"
        static let isBiDirectional = "isBiDirectional"
        static let userGroupMemberReqList = "userGroupMemberReqList"
        static let groupCode = "groupCode"
        static let lookrUserIds = "lookrUserIds"
        static let groupLocationId = "groupLocationId"
        static let userMemberId = "userMemberId"
        static let isBidirection = "isBidirection"
    }
    
    struct LocationKeys{
        static let userLocationId = "userLocationId"
        static let lat = "lat"
        static let lng = "lng"
        static let address = "address"
        static let name = "name"
        static let locationId = "locationId"
        static let groupId = "groupId"
        static let longitude = "longitude"
        static let latitude = "latitude"
        static let userGroupId = "userGroupId"
        static let groupLocationId = "groupLocationId"
        static let groupLocationMembersReqList = "groupLocationMembersReqList"
        static let groupLocationMemberId = "groupLocationMemberId"
        static let userGroupMemberId = "userGroupMemberId"
        static let isNotificationOn = "isNotificationOn"
        static let IsBiDirectionTracking = "IsBiDirectionTracking"
        static let inTime = "inTime"
        static let outTime = "outTime"
        static let isDeleted = "isDeleted"
        static let days = "days"
        static let userNotificationIds = "userNotificationIds"
       
    }
    
    struct PackageKeys{
        static let deviceCode = "deviceCode"
        static let pcakgeId = "pcakgeId"
        static let packageId = "packageId"
        static let subscribedOn = "subscribedOn"
        static let statusId = "statusId"
        static let qty = "qty"
        static let deviceStatusCode = "deviceStatusCode"
        
    }
    
    struct RequestKeys {
        static let vehicleCode = "vehicleCode"
        static let routeCode = "routeCode"
        static let passengerCode = "passengerCode"
        static let statusId = "statusId"
        static let requestAccessId = "requestAccessId"
        static let otp = "otp"
    }
    
    struct DeviceKeys {
        static let userGpsId = "userGpsId"
        static let userGroupIds = "userGroupIds"
        static let organizationGPSId = "organizationGPSId"
        static let vehiclecode = "vehiclecode"
        static let message = "message"
    }
    
    struct PaymentKeys {
        static let userPackageId = "userPackageId"
        static let status = "status"
        static let totalAmount = "totalAmount"
        static let gstAmount = "GSTAmount"
        static let trancation_Id = "trancation_Id"
        static let locationId = "locationId"
        static let modeOfPayment = "modeOfPayment"
        static let paymentDate = "paymentDate"
        static let deviceSelected = "deviceSelected"
        
    }
    
    struct AddAddressKeys {
        static let userName = "userName"
        static let address = "address"
        static let landmark = "landmark"
        static let cityId = "cityId"
        static let mobileNumber = "mobileNumber"
        static let pincode = "pincode"
        static let shipType = "shipType"
        static let shipId = "shipId"
    }
    
    struct PostReviewKeys {
        static let productId = "productId"
        static let id = "id"
        static let comments = "comments"
        static let title = "title"
        static let ratings = "ratings"
        static let userName = "userName"
    }
    
    
    struct LoginKeys {
        static let emailAddress = "emailAddress"
        static let mobileNumber = "mobileNumber"
        static let userPassword = "userPassword"
        static let ipAddress = "ipAddress"
        static let deviceType = "deviceType"
    }
    
    struct resetPasswordKeys {
        static let mobileNumber = "mobileNumber"
        static let userPassword = "userPassword"
        static let sessionId = "sessionId"
        static let ipaddress = "ipaddress"
    }
    

    
 
    struct UpdateProfileKeys{
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let gender = "gender"
        static let emailAddress = "emailAddress"
    }
    

    struct changePasswordKeys{
        static let mcId = "mcId"
        static let currentPassword = "currentPassword"
        static let newPassword = "newPassword"
    }
    
    struct changeMobileNumberKeys{
        static let merchantId = "merchantId"
        static let mobileNumber = "mobileNumber"
        static let userPassword = "userPassword"
    }
    
    struct ApplyNewMobileNumberKeys {
        static let merchantId = "merchantId"
        static let currentMobileNo = "currentMobileNo"
        static let merchantName = "merchantName"
    }
    
    struct MobileVerifyOtpKeys {
        static let merchantId = "merchantId"
        static let otpCode = "otpCode"
        static let merchantName = "merchantName"
    }
    
    struct AddUserKeys {
        static let merchantId = "merchantId"
        static let userName = "userName"
        static let userMobile = "userMobile"
        static let ipAddress = "ipAddress"
        static let deviceName = "deviceName"
        static let deviceModel = "deviceModel"
        static let fireBaseId = "fireBaseId"
    }
}
