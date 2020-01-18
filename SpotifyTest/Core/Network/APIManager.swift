//
//  APIManager.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire
import Kingfisher

final class APIManager : UIViewController  {
    

    static let shared = APIManager()
    private let disposeBag = DisposeBag()
    public let loadingDoneOnError: PublishSubject<Bool> = PublishSubject()
    
    class func headers() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        return headers
    }

    func requestfromURL<T: Codable>(url: String , method: Alamofire.HTTPMethod , decodeModel: T.Type , params: [String:Any]? = nil , encoding:ParameterEncoding = JSONEncoding.default , header: [String:String]? = nil ,  completionHandler: @escaping (T) -> Void) {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        RxAlamofire.requestJSON(method , url, parameters: params , encoding: encoding , headers: header)
        .subscribe(onNext: { [unowned self] (r,json) in
            
            switch r.statusCode {
            case 200 :
                
                if let dict = json as? [String: AnyObject] {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                        do {
                            let decoder = JSONDecoder()
                            let dataModel = try decoder.decode(decodeModel.self, from: jsonData)
                            print(url)
                            print(dataModel)
                            completionHandler(dataModel)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                
                }
                UIApplication.shared.endIgnoringInteractionEvents()
                break
            case 401 :
                print("401")
                break
            case 500 :
                print("500")
                break
            default:
                break
            }
        
                                
        }, onError: { error in
        }).disposed(by: disposeBag)
    }
    
    func downloadImage(_ urlString: String,  completionHandler: @escaping (UIImage) -> ()) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                completionHandler(value.image)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


