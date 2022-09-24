//
//  HttpRequestHelper.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import UIKit
import Alamofire

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(" GET Method ")
        print(" \(url) ")
        print(" \(params) ")
        
        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        
        
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}

extension HttpRequestHelper {
    func POST(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        let boundary = "Boundary-\(UUID().uuidString)"
        let  httpHeaderr = ["content-type": "application/x-www-form-urlencoded"]

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
        }, usingThreshold: UInt64.init(), to:url,method:.post,
                         headers: httpHeaderr){ (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    debugPrint(response)
                    if response.error != nil{
                        complete(false, response.data)
                    }
                    complete(true, response.data)
                }
                upload.uploadProgress(closure: {
                    progress in
                    
                    print(progress.fractionCompleted)
                })
            case .failure(let encodingError):
                
                print(encodingError)
            }
        }
    }
}

extension HttpRequestHelper {
    func uploadImagePOST(url: String, params: [String: String], fileName: String, image: UIImage, httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let  httpHeaderr = ["Content-Type":"multipart/form-data; boundary=\(boundary)"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image != nil {
                if let image = image as? UIImage{
                    multipartFormData.append(image.jpegData(compressionQuality:0.5)!, withName:"profile_pic", fileName: "profile_pic.jpeg", mimeType: "image/jpeg")
                }
            }
            
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
        }, usingThreshold: UInt64.init(), to:url,method:.post,
                         headers: httpHeaderr){ (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { (response) in
                    debugPrint(response)
                    if response.error != nil{
                        complete(false, response.data)
                    }
                    complete(true, response.data)
                }
                upload.uploadProgress(closure: {
                    progress in
                    
                    print(progress.fractionCompleted)
                })
            case .failure(let encodingError):
                
                print(encodingError)
            }
        }
    }
}
