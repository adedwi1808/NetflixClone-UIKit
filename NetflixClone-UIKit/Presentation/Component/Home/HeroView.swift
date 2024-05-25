//
//  HeroView.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 24/05/24.
//

import UIKit

class HeroView: UIView {
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "posterImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let heroFooterView: HeroFooterView = {
        let view = HeroFooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gradientOverlay: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(posterImageView)
        addSubview(heroFooterView)
        
        configurePosterImageView()
        configureHeroFooterView()
        configureGradientLayer()
    }
    
    private func configurePosterImageView() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureHeroFooterView() {
        NSLayoutConstraint.activate([
            heroFooterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroFooterView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            heroFooterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroFooterView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureGradientLayer() {
        posterImageView.layer.addSublayer(gradientOverlay)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientOverlay.frame = posterImageView.bounds
    }
}

