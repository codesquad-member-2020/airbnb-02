//
//  ImagePagingView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/22.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class ImagePagingView: UIView {
    //MARK:- IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        insertXibView()
    }
}

extension ImagePagingView: XibRepresentable { }
