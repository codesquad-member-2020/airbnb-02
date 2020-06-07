//
//  BNBsSuccessMock.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/07.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct BNBsSuccessMock: NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let jsonData = Data.readJSON(for: "BNBsData") else { return }
        completionHandler(jsonData, nil, nil)
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) {
        
    }
}
