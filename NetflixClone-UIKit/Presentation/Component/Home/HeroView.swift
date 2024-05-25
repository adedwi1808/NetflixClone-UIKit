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
    
    private let movieCategoriesLabel: UILabel = {
       var label = UILabel()
        label.text = "Categori 1 - Categori 2"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categories: [String] = [
        "Category 1",
        "Category 2",
        "Category 3"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        movieCategoriesLabel.text = categories.joined(separator: " • ")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(posterImageView)
        addSubview(heroFooterView)
        addSubview(movieCategoriesLabel)
        
        configurePosterImageView()
        configureHeroFooterView()
        configureGradientLayer()
        configureCategoriesLabel()
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
    
    private func configureCategoriesLabel() {
        NSLayoutConstraint.activate([
            movieCategoriesLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -10),
            movieCategoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieCategoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieCategoriesLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientOverlay.frame = posterImageView.bounds
    }
}

