//
//  HomeViewController.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import UIKit

enum HomeSection: Int, CaseIterable {
    case nowPlaying = 0
    case popular = 1
    case topRated = 2
    case upcoming = 3
    case trendingMovie = 4
    case trendingTv = 5
    
    func pageTitleValue() -> String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .trendingMovie:
            return "Trending Movie"
        case .trendingTv:
            return "Trending TV"
        }
    }
}

class HomeViewController: UITableViewController {
    weak var coordinator: Coordinator?
    private var viewModel: HomeViewModelProtocol?
    
    init(viewModel: any HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.delegate = self
        
        configureNavbar()
        configureTableView()
        
        viewModel?.viewDidLoad()
    }
    
    private func configureNavbar() {
        let logoImage = UIImage(named: "netflixLogo")
        let imageView = UIImageView(image: logoImage)
        
        imageView.contentMode = .scaleAspectFit
        let height: CGFloat = 30
        let width = height * (logoImage?.size.width ?? 1) / (logoImage?.size.height ?? 1)
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let containerView = UIView(frame: imageView.frame)
        containerView.addSubview(imageView)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "airplayvideo"),
            style: .done,
            target: self,
            action: nil
        )
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureTableView() {
        tableView.register(MovieSectionCell.self, forCellReuseIdentifier: MovieSectionCell.identifier)
        let hero = HeroView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 360))
        tableView.tableHeaderView = hero
    }
}


//MARK: - Table Delegate and DataSource
extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieSectionCell.identifier,
            for: indexPath
        ) as? MovieSectionCell else {
            return UITableViewCell()
        }
                switch indexPath.section {
                case HomeSection.nowPlaying.rawValue:
                    break
        //            cell.textLabel?.text = HomeSection.nowPlaying.pageTitleValue()
        //        case HomeSection.popular.rawValue:
        //            cell.textLabel?.text = HomeSection.popular.pageTitleValue()
        //        case HomeSection.topRated.rawValue:
        //            cell.textLabel?.text = HomeSection.topRated.pageTitleValue()
        //        case HomeSection.upcoming.rawValue:
        //            cell.textLabel?.text = HomeSection.upcoming.pageTitleValue()
        //        case HomeSection.trendingMovie.rawValue:
        //            cell.textLabel?.text = HomeSection.trendingMovie.pageTitleValue()
        //        case HomeSection.trendingTv.rawValue:
        //            cell.textLabel?.text = HomeSection.trendingTv.pageTitleValue()
                default:
                    break
        //            cell.textLabel?.text = "--"
                }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        HomeSection(rawValue: section)?.pageTitleValue()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        210
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.textAlignment = .left
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
}

extension HomeViewController: HomeViewModelDelegateProtocol {
    func onSuccessGetNowPlaying() {
        tableView.reloadSections(IndexSet(integer: HomeSection.nowPlaying.rawValue), with: .automatic)
    }
}
