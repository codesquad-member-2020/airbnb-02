//
//  AFSession.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

import Alamofire

extension Session: NetworkDispatcher, NetworkDownloader {
    func execute(
        request: Request,
        completionHandler: @escaping (Data?, URLResponse?) -> (),
        failureHandler: @escaping (URLResponse?, Error?) -> ()
    ) throws {
        guard let urlRequest = request.urlRequest() else { throw NetworkErrorCase.invalidURL }
        
        self.request(urlRequest).validate().response { afDataResponse in
            switch afDataResponse.result {
            case .success(let data):
                completionHandler(data, afDataResponse.response)
            case .failure(let error):
                failureHandler(afDataResponse.response, error)
            }
        }
    }
    
    func download(
        url: URL,
        completionHandler: @escaping (URL?, URLResponse?) -> (),
        failureHandler: @escaping (URLResponse?, Error?) -> ()
    ) {
        self.download(url).validate().response { afDownloadResponse in
            switch afDownloadResponse.result {
            case .success(let tempURL):
                completionHandler(tempURL, afDownloadResponse.response)
            case .failure(let error):
                failureHandler(afDownloadResponse.response, error)
            }
        }
    }
}
