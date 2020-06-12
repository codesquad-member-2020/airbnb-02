//
//  NetworkDownloader.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/12.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

protocol NetworkDownloader {
    func download(url: URL, completionHandler: @escaping (URL? , URLResponse?, Error?) -> ())
}
