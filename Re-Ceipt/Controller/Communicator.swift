//
//  Communicator.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 13..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import AlamofireImage


class Communicator {
    static var serverURL: String = "http://127.0.0.1:8000/"
//    static var serverURL: String = "http://52.78.44.214:8000/"
    static var headers = [String:String]()
    
    static func showActivityIndicatory(parent: UIView) -> UIActivityIndicatorView{
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        let orig = CGPoint(x: 0.0, y: 0.0)
        let size = CGSize(width: 40.0, height: 40.0)
        actInd.frame = CGRect(origin: orig, size: size)
        actInd.center = parent.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        parent.isUserInteractionEnabled = false
        parent.alpha = 0.66
        parent.addSubview(actInd)
        actInd.startAnimating()
        return actInd
    }
    
    static func stopActivityIndicatory(parent: UIView, actInd: UIActivityIndicatorView) {
        parent.isUserInteractionEnabled = true
        parent.alpha = 1
        actInd.removeFromSuperview()
    }
    
    static func signUp(_ parent: UIView, username: String, password: String, onSuccess: @escaping () -> Void) {
        let api = "signup/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .post,
            parameters: ["username": username, "password": password],
            headers: headers)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind);
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from fetchAllRooms service")
                    onFail(parent, ind);
                    return
                }
                
                let message = value["Status"] as! String
                if message == "Success" {
                    stopActivityIndicatory(parent: parent, actInd: ind)
                    onSuccess()
                }
                else {
                    onFail(parent, ind);
                }
        }
    }
    
    static func signIn(_ parent: UIView, username: String, password: String, onSuccess: @escaping () -> Void) {
        let api = "login/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .post,
            parameters: ["username": username, "password": password],
            headers: headers)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind)
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from fetchAllRooms service")
                    onFail(parent, ind)
                    return
                }
                
                headers["Authorization"] = "Token " + (value["token"] as! String)
                stopActivityIndicatory(parent: parent, actInd: ind)
                onSuccess()
        }
    }
    
    
    static func addSpend(_ parent: UIView, title: String, type: String, amount: Int, onSuccess: @escaping () -> Void) {
        let api = "spend/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .post,
            parameters: ["title": title, "type": type, "amount": amount],
            encoding: JSONEncoding.default,
            headers: headers
            )
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind)
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from fetchAllRooms service")
                    onFail(parent, ind)
                    return
                }
                
                stopActivityIndicatory(parent: parent, actInd: ind)
                onSuccess()
        }
    }
    
    static func getMySpend(_ parent: UIView, onSuccess: @escaping ([Spend]) -> Void) {
        let api = "myspend/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
            )
            .validate()
            .responseArray { (response: DataResponse<[Spend]>) in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind)
                    return
                }
            
                stopActivityIndicatory(parent: parent, actInd: ind)
                if let spendList = response.result.value {
                    onSuccess(spendList)
                }
        }
    }
    
    
    static func getPostList(_ parent: UIView, onSuccess: @escaping ([Post]) -> Void) {
        let api = "post/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
            )
            .validate()
            .responseArray { (response: DataResponse<[Post]>) in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind)
                    return
                }
                
                stopActivityIndicatory(parent: parent, actInd: ind)
                if let postList = response.result.value {
                    onSuccess(postList)
                }
        }
    }
    
    static func getMyPostList(_ parent: UIView, onSuccess: @escaping ([Post]) -> Void) {
        let api = "mypost/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
            )
            .validate()
            .responseArray { (response: DataResponse<[Post]>) in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind)
                    return
                }
                
                stopActivityIndicatory(parent: parent, actInd: ind)
                if let postList = response.result.value {
                    onSuccess(postList)
                }
        }
    }
    
    
    static func getImage(_ parent: UIView, onSuccess: @escaping (UIImage) -> Void) {
        let api = "image/"
        let ind = showActivityIndicatory(parent: parent)
        
        Alamofire.request(
            URL(string: serverURL + api)!,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
            )
            .validate()
            .responseImage { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    onFail(parent, ind)
                    return
                }
                
                if let image = response.result.value {
                    onSuccess(image)
                }
        }
    }
    
    static func onFail(_ parent: UIView, _ ind: UIActivityIndicatorView) {
        stopActivityIndicatory(parent: parent, actInd: ind)
    }
}
