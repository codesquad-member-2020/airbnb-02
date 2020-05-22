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
        configureScrollViewDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        insertXibView()
        configureScrollViewDelegate()
    }
    
    private func configureScrollViewDelegate() {
        scrollView.delegate = self
    }
}

extension ImagePagingView: XibRepresentable { }

extension ImagePagingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let dividend = scrollView.contentOffset.x
        let divisor = scrollView.frame.maxX
        guard let remainder = modular(
            dividend: dividend,
            divisor: divisor
            ), remainder == 0 else { return }
        
        guard let currentPage = quotient(
            dividend: dividend,
            divisor: divisor
            ) else { return }
        
        pageControl.currentPage = currentPage
    }
    
    private func modular(dividend: CGFloat, divisor: CGFloat) -> CGFloat? {
        guard divisor != 0 else { return nil }
        return dividend.truncatingRemainder(dividingBy: divisor)
    }
    
    private func quotient(dividend: CGFloat, divisor: CGFloat) -> Int? {
        guard divisor != 0 else { return nil }
        let quotient = dividend / divisor
        return Int(quotient)
    }
}

