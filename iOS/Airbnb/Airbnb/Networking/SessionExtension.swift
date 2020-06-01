//
//  SessionExtension.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

import Alamofire

extension Session: NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let urlRequest = request.urlRequest() else {
            completionHandler(nil, nil, NetworkErrorCase.invalidURL)
            return
        }
        self.request(urlRequest).validate().response { afDataResponse in
            completionHandler(afDataResponse.data, afDataResponse.response, afDataResponse.error)
        }
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) {
        download(url).validate().response { afDownloadResponse in
            switch afDownloadResponse.result {
            case .success(let tempURL):
                completionHandler(tempURL, afDownloadResponse.response, nil)
            case .failure(let error):
                completionHandler(nil, afDownloadResponse.response, error)
            }
        }
    }
}
