//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import UIKit

final class PokemonListViewController: UIViewController {

    private let viewModel = PokemonListViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let itemWidth = (view.bounds.width - (3 * spacing)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Buscar Pokemon"
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        viewModel.fetchPokemons()
    }

    private func setupViews() {
        title = "Pokedex"
        view.backgroundColor = .white
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }

        viewModel.onError = { error in
            print("Error loading pokemons:", error)
        }
    }
}

extension PokemonListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else {
            return UICollectionViewCell()
        }
        let pokemon = viewModel.pokemon(at: indexPath.item)
        cell.configure(with: pokemon)
        return cell
    }
}

extension PokemonListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemon(at: indexPath.item)
        let detailVM = PokemonDetailViewModel(pokemon: pokemon)
        let detailVC = PokemonDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPokemons(with: searchText)
    }
}
