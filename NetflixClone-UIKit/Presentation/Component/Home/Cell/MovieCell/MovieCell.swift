//
//  MovieCell.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 31/05/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let identifier: String = "MoviewCell"
    
    private var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private var urlSessionTask: URLSessionDataTask? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        posterView.image = nil
        posterView.startShimmering()
    }
    
    
    
    func configure(path: String) {
        posterView.startShimmering()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") else { return }
        let urlRequest = URLRequest(url: url)
        urlSessionTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, err in
            guard let self else { return }
            guard let data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.posterView.stopShimmering()
                self.posterView.image = image
            }
        }
        
        urlSessionTask?.resume()
    }
    
    func onDissapear() {
        urlSessionTask?.cancel()
    }
}
