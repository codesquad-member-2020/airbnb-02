//
//  AFSession.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

import Alamofire

final class AFSession: NetworkDispatcher {
    private let session: Session
    
    init(with session: Session = .default) {
        self.session = session
    }
    
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let urlRequest = request.urlRequest() else {
            completionHandler(nil, nil, NetworkErrorCase.invalidURL)
            return
        }
        session.request(urlRequest).validate().response { afDataResponse in
            completionHandler(afDataResponse.data, afDataResponse.response, afDataResponse.error)
        }
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) {
        session.download(url).validate().response { afDownloadResponse in
            switch afDownloadResponse.result {
            case .success(let tempURL):
                completionHandler(tempURL, afDownloadResponse.response, nil)
            case .failure(let error):
                completionHandler(nil, afDownloadResponse.response, error)
            }
        }
    }
}
