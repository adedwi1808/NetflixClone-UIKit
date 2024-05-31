//
//  MovieSectionCell.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 25/05/24.
//

import UIKit

enum MovieSectionType {
    case movie
    case tvProgram
}

class MovieSectionCell: UITableViewCell {
    
    static let identifier: String = "MovieSectionCell"
    
    private var viewModel: MovieSectionViewModelProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 210)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func configureView() {
        contentView.addSubview(collectionView)
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func bind(viewModel: MovieSectionViewModel) {
        self.viewModel = viewModel
        
        collectionView.reloadData()
    }
    
}

extension MovieSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCell.identifier,
            for: indexPath
        ) as? MovieCell else { return UICollectionViewCell()}
        guard let viewModel else { return UICollectionViewCell()}
        
        switch viewModel.type {
        case .movie:
            let path: String = viewModel.movies[indexPath.row].posterPath
            cell.configure(path: path)
        case .tvProgram:
            let path: String = viewModel.tvPrograms[indexPath.row].posterPath
            cell.configure(path: path)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0}
        
        switch viewModel.type {
        case .movie:
            return viewModel.movies.count
        case .tvProgram:
            return viewModel.tvPrograms.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCell else { return }
        cell.onDissapear()
    }
}
