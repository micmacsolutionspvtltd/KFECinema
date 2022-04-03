//
//  Endpoints.swift
//  FitKet
//
//  Created by Hariharan G on 5/19/20.
//  Copyright © 2020 Fitket. All rights reserved.
//

import UIKit
import SystemConfiguration

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum Endpoint {
    case getOtp
    case verifyOtp
    case signUp
    case getAllGroupByUserId
    case getAllPackage
    case getAllPackagesWithSubPackage
    case getAllUserMemberByUserId
    case getActivePackageByUserId
    case getAllNotificationByUserId
    case deleteUserNotificaions
    case sendAllUserChatNotification
    case getUserById
    case saveUser
    case getLocationByUserId
    case deleteUserLocationById
    case updateUserLocation
    case saveUserLocation
    case getAllGpsGroupByUserId
    case getAllGPSDeviceByOrganizationGPS
    case createGroup
    case getAllCreatedGroupByUserId
    case getAllUserMemberByUserGroupIdAndGeoLocation
    case deleteGroup
    case getGroupShareMessage
    case getAllLookrContactsByUser
    case inviteLookrContacts
    case joinGroupByUserId
    case removeMemberByGroupMemberId
    case saveUserGroupMemberByMemberId
    case getGroupByUserIdAndGroupId
    case leaveGroupByMember
    case locationCreateByUser
    case addGroupLocation
    case removeGroupLocation
    case sendGroupChatNotification
    
    var url: (_ config: Configuration) -> String {
        return { return $0.baseURL + "/" + self.path }
    }
    
    
    private var path: String {
        switch self {
        case .getOtp:
           return "getOTPByMobile"
        case .verifyOtp:
            return "verifyOTPByMobile"
        case .signUp:
            return "verifyOTPForSignUp"
        case .getAllGroupByUserId:
            return "getAllGroupByUserId"
        case .getAllPackage:
            return "getAllPackage"
        case .getAllPackagesWithSubPackage:
            return "getAllPackagesWithSubPackage"
        case .getAllUserMemberByUserId:
            return "getAllUserMemberByUserId"
        case .getActivePackageByUserId:
            return "getActivePackageByUserId"
        case .getAllNotificationByUserId:
            return "getAllNotificationByUserId"
        case .deleteUserNotificaions:
            return "deleteUserNotificaions"
        case .sendAllUserChatNotification:
            return "sendAllUserChatNotification"
        case .getUserById:
            return "getUserById"
        case .saveUser:
            return "saveUser"
        case .getLocationByUserId:
            return "getLocationByUserId"
        case .deleteUserLocationById:
            return "deleteUserLocationById"
        case .updateUserLocation:
            return "updateUserLocation"
        case .saveUserLocation:
            return "saveUserLocation"
        case .getAllGpsGroupByUserId:
            return "getAllGpsGroupByUserId"
        case .getAllGPSDeviceByOrganizationGPS:
            return "getAllGPSDeviceByOrganizationGPS"
        case .createGroup:
            return "createGroup"
        case .getAllCreatedGroupByUserId:
            return "getAllCreatedGroupByUserId"
        case .getAllUserMemberByUserGroupIdAndGeoLocation:
            return "getAllUserMemberByUserGroupIdAndGeoLocation"
        case .deleteGroup:
            return "deleteGroup"
        case .getGroupShareMessage:
            return "getGroupShareMessage"
        case .getAllLookrContactsByUser:
            return "getAllLookrContactsByUser"
        case .inviteLookrContacts:
            return "inviteLookrContacts"
        case .joinGroupByUserId:
            return "joinGroupByUserId"
        case .removeMemberByGroupMemberId:
            return "removeMemberByGroupMemberId"
        case .saveUserGroupMemberByMemberId:
            return "saveUserGroupMemberByMemberId"
        case .getGroupByUserIdAndGroupId:
            return "getGroupByUserIdAndGroupId"
        case .locationCreateByUser:
            return "locationCreateByUser"
        case .addGroupLocation:
            return "addGroupLocation"
        case .removeGroupLocation:
            return "removeGroupLocationByGroupLocationId"
        case .sendGroupChatNotification:
            return "sendChatNotification"
        case .leaveGroupByMember:
        return "leaveGroupByMemberIdAndGroupId"
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .getOtp,.signUp,.verifyOtp,.getAllGroupByUserId,.getAllPackage,.getAllPackagesWithSubPackage,.getAllUserMemberByUserId,.getActivePackageByUserId,.getAllNotificationByUserId,.deleteUserNotificaions,.sendAllUserChatNotification,.getUserById,.saveUser,.getLocationByUserId,.deleteUserLocationById,.updateUserLocation,.saveUserLocation,.getAllGpsGroupByUserId,.getAllGPSDeviceByOrganizationGPS,.createGroup,.getAllCreatedGroupByUserId,.getAllUserMemberByUserGroupIdAndGeoLocation,.deleteGroup,.getGroupShareMessage,.getAllLookrContactsByUser,.inviteLookrContacts,.joinGroupByUserId,.removeMemberByGroupMemberId,.saveUserGroupMemberByMemberId,.addGroupLocation,.leaveGroupByMember,.removeGroupLocation, .sendGroupChatNotification,.getGroupByUserIdAndGroupId,.locationCreateByUser:
            return .post
        }
    }
}
