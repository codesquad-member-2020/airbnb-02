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
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
        configureStackView()
        configurePageControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureScrollView()
        configureStackView()
        configurePageControl()
    }
    
    func configure(count: Int) {
        configureStackView(count: count)
        configurePageControl(count: count)
    }
    
    func insert(at index: Int, image: UIImage) {
        guard index < stackView.arrangedSubviews.count,
            let imageView = stackView.arrangedSubviews[index] as? UIImageView else { return }
        
        imageView.image = image
    }
    
    private func configureStackView(count: Int) {
        (0 ..< count).forEach { _ in
            let imageView = UIImageView()
            configure(imageView: imageView)
            stackView.addArrangedSubview(imageView)
            configureConstraints(imageView: imageView)
        }
    }
    
    private func configurePageControl(count: Int) {
        pageControl.numberOfPages = count
    }
    
    private func configure(imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
    }
    
    private func configureConstraints(imageView: UIImageView) {
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    private func configureScrollView() {
        scrollView.delegate = self
        configureScrollViewConstraints()
    }
    
    private func configureScrollViewConstraints() {
        addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func configureStackView() {
        scrollView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        scrollView.contentLayoutGuide.widthAnchor
            .constraint(equalTo: stackView.widthAnchor)
            .isActive = true
    }
    
    private func configurePageControl() {
        addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

extension ImagePagingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let dividend = scrollView.contentOffset.x
        let divisor = scrollView.frame.maxX
        guard let remainder = Math.modular(
            of: dividend,
            divideBy: divisor
            ), remainder == 0 else { return }
        
        guard let currentPage = Math.quotient(
            of: dividend,
            divideBy: divisor
            ) else { return }
        
        pageControl.currentPage = currentPage
    }
}

struct Math {
    static func modular(of dividend: CGFloat, divideBy divisor: CGFloat) -> CGFloat? {
        guard divisor != 0 else { return nil }
        return dividend.truncatingRemainder(dividingBy: divisor)
    }
    
    static func quotient(of dividend: CGFloat, divideBy divisor: CGFloat) -> Int? {
        guard divisor != 0 else { return nil }
        let quotient = dividend / divisor
        return Int(quotient)
    }
}
