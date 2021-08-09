//
//  RestaurantsMainViewController.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import UIKit

class RestaurantsMainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.boundToSuperView()
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private let mainViewModel: RestaurantsViewModel
    
    init(viewModel: RestaurantsViewModel = RestaurantsViewModel()) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainViewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        } errHandler: { [weak self] (err) in
            self?.presentErrorAlertController(for: err)
        }
        self.mainViewModel.launchRestaurants()
        print("Code ran here")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
}

extension RestaurantsMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.reuseIdentifier, for: indexPath) as? RestaurantCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.contentView.backgroundColor = (indexPath.item.isMultiple(of: 2)) ? .red : .blue
        cell.configure(with: self.mainViewModel.restaurantDetailViewModel(for: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainViewModel.count
    }
}

extension RestaurantsMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize(width: self.view.frame.width, height: 180)
        default:
            return CGSize(width: (self.view.frame.width - 5) / 2, height: 180)
        }
    }
}

extension RestaurantsMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = RestaurantDetailViewController(restaurantDetailViewModel: self.mainViewModel.restaurantDetailViewModel(for: indexPath.row)) else { return }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
