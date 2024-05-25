//
//  HeroFooterView.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 25/05/24.
//

import UIKit

class HeroFooterView: UIView {
    
    private var playButtonView: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setTitle(" Play", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .red
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return button
    }()
    
    private var favoriteButtonView: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setTitle(" Favorite", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(playButtonView)
        addSubview(favoriteButtonView)
        
        configurePlayButton()
        configureFavoriteButton()
    }
    
    private func configurePlayButton() {
        NSLayoutConstraint.activate([
            playButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            playButtonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            playButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            playButtonView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureFavoriteButton() {
        NSLayoutConstraint.activate([
            favoriteButtonView.leadingAnchor.constraint(equalTo: playButtonView.trailingAnchor, constant: 12),
            favoriteButtonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            favoriteButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
    }
    
    
}
