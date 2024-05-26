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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        )
        
        switch viewModel?.type {
        case .movie:
            cell.backgroundColor = .yellow
        case .tvProgram:
            cell.backgroundColor = .red
        case .none:
            cell.backgroundColor = .green
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
}
