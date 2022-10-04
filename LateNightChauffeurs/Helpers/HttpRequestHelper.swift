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
    func POST(url: String, params: [String: Any], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        let boundary = "Boundary-\(UUID().uuidString)"
        guard let url = URL(string: url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        switch httpHeader {
        case .application_json:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        case .application_x_www_form_urlencoded:
            //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            //urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Accept")
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
        case .none: break
        }
        
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Array<Any> {
                    let keyObj = key
                    
                    do {
                        let dataStops =  try JSONSerialization.data(withJSONObject:temp, options: .prettyPrinted)
                        multiPart.append(dataStops, withName: keyObj)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    //                    temp.forEach({ element in
                    //                        let keyObj = key //+ "[]"
                    //                        if let string = element as? String {
                    //                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                    //                        } else
                    //                        if let num = element as? Int {
                    //                            let value = "\(num)"
                    //                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                    //                        }
                    //                    })
                }
            }
            
             
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    //let asJSON = try JSONSerialization.jsonObject(with: data)
                   // let model = try JSONDecoder().decode(ProfileUserData.self, from: data)
                    // Handle as previously success
                    complete(true, response.data)
                } catch {
                    complete(false, response.data)
                }
            case .failure(let error):
                // Handle as previously error
                print(error)
                complete(false, nil)
            }
        }
    }
}
extension HttpRequestHelper {
    //Profile Pic uplaod
    func uploadImagePOST(url: String, params: [String: Any], fileName: String, picImage: UIImage?, httpHeader: HTTPHeaderFields, profileStruct : uploadImage, completion: @escaping (Bool, ProfileUserData?) -> ()) {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        guard let url = URL(string: url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        switch httpHeader {
        case .application_json:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        case .application_x_www_form_urlencoded:
            //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            //urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Accept")
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
        case .none: break
        }
        
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if profileStruct.imagetype == "Device" {
                if let imagePic = picImage {
                    if let datar = imagePic.jpegData(compressionQuality: 0.5)  {
                        multiPart.append(datar, withName: fileName, fileName: "\(fileName).jpg", mimeType: "image/jpg")
                    }
                }
            }
            else {
                if let ImageURL = URL(string : profileStruct.ImageUrl ?? "") {
                    //load some image
                    do {
                        let imageData = try Data(contentsOf: ImageURL)
                        multiPart.append(imageData, withName: fileName, fileName: "\(fileName).jpg", mimeType: "image/jpg")
                    } catch {
                        print("Unable to load image: \(error)")
                    }
                }
            }
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    //let asJSON = try JSONSerialization.jsonObject(with: data)
                    let model = try JSONDecoder().decode(ProfileUserData.self, from: data)
                    // Handle as previously success
                    completion(true, model)
                } catch {
                    completion(false, nil)
                }
            case .failure(let error):
                // Handle as previously error
                print(error)
                completion(false, nil)
            }
        }
    }
}

struct uploadImage {
    var Imagepic: UIImage?
    var ImageName : String?
    var imagetype : String? // Device one
    var ImageUrl : String?
 }
