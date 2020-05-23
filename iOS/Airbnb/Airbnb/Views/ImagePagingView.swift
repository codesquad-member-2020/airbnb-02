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
    
    func configure(count: Int) {
        configureStackView(count: count)
        configurePageControl(count: count)
    }
    
    private func configureStackView(count: Int) {
        (0 ..< count).forEach { _ in
            let imageView = UIImageView()
            configure(imageView: imageView)
            stackView.addArrangedSubview(imageView)
            configureConstraints(imageView: imageView)
        }
    }
    
    private func configure(imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
    }
    
    private func configureConstraints(imageView: UIImageView) {
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    private func configurePageControl(count: Int) {
        pageControl.numberOfPages = count
    }
    
    func insert(at index: Int, image: UIImage) {
        guard index < stackView.arrangedSubviews.count,
            let imageView = stackView.arrangedSubviews[index] as? UIImageView else { return }
        
        imageView.image = image
    }
}

extension ImagePagingView: XibRepresentable { }

extension ImagePagingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let dividend = scrollView.contentOffset.x
        let divisor = scrollView.frame.maxX
        guard let remainder = Math.modular(
            dividend: dividend,
            divisor: divisor
            ), remainder == 0 else { return }
        
        guard let currentPage = Math.quotient(
            dividend: dividend,
            divisor: divisor
            ) else { return }
        
        pageControl.currentPage = currentPage
    }
}

struct Math {
    static func modular(dividend: CGFloat, divisor: CGFloat) -> CGFloat? {
        guard divisor != 0 else { return nil }
        return dividend.truncatingRemainder(dividingBy: divisor)
    }
    
    static func quotient(dividend: CGFloat, divisor: CGFloat) -> Int? {
        guard divisor != 0 else { return nil }
        let quotient = dividend / divisor
        return Int(quotient)
    }
}

