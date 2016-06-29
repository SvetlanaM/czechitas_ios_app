//
//  DataManager.swift
//  czechitas-mobile-app
//
//  Created by Svetlana Margetová on 06.06.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension Manager {
    static let baseURL = "https://czechitas-app.herokuapp.com:443/api/v1"
}

enum APIRouter: URLRequestConvertible {
    
    case Cities()
    case CoursesPrepared()
    case CoursesOpen()
    case CoursesAll()
    case Venues()
    case Update(timestamp : Int)
    
    var URLRequest: NSMutableURLRequest {
        let path : String = {
            switch self
            {
            case .Cities:
                return ("/cities/")
            case .CoursesPrepared:
                return ("/courses/prepared/")
            case .CoursesOpen:
                return ("/courses/open/")
            case .CoursesAll:
                return ("/courses/all/")
            case .Venues:
                return ("/courses/")
            case .Update:
                return ("/update-from=1464889500/")
            }
        }()

        if let URL = NSURL(string: Alamofire.Manager.baseURL) {
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        return URLRequest
        }
        return NSMutableURLRequest()
    }
}

class APIManager {
    static let sharedInstance = APIManager()

    func callAPI(method : APIRouter, onComplete : ((data : JSON) -> Void)) {
        Alamofire.request(method)
        .validate()
        .responseJSON { response in
            if let value = response.result.value {
                let valueJSON = JSON(value)
                onComplete(data: valueJSON)
            }
        }
    }
    
    
    
    
}


