//
//  NetworkDispatcher.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ())
    
    func download(url: URL, completionHandler: @escaping (URL? , URLResponse?, Error?) -> ())
}
