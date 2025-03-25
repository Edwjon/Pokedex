//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    
    private let viewModel: PokemonDetailViewModel
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let evolutionLoader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private let typesTitleLabel = PokemonDetailViewController.makeTitleLabel(text: "Tipo(s)")
    private let typesLabel = PokemonDetailViewController.makeDetailLabel()
    
    private let movesTitleLabel = PokemonDetailViewController.makeTitleLabel(text: "Movimientos")
    private let movesLabel = PokemonDetailViewController.makeDetailLabel()
    
    private let evolutionTitleLabel = PokemonDetailViewController.makeTitleLabel(text: "Evolución")
    private let evolutionLabel = PokemonDetailViewController.makeDetailLabel()
    
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configure()
        loadNetworkRequests()
    }
    
    private func setupViews() {
        title = viewModel.name
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(infoContainer)
        
        infoContainer.addSubview(typesTitleLabel)
        infoContainer.addSubview(typesLabel)
        infoContainer.addSubview(movesTitleLabel)
        infoContainer.addSubview(movesLabel)
        infoContainer.addSubview(evolutionTitleLabel)
        infoContainer.addSubview(evolutionLabel)
        infoContainer.addSubview(evolutionLoader)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            idLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            infoContainer.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 30),
            infoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            typesTitleLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 20),
            typesTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            
            typesLabel.topAnchor.constraint(equalTo: typesTitleLabel.bottomAnchor, constant: 8),
            typesLabel.leadingAnchor.constraint(equalTo: typesTitleLabel.leadingAnchor),
            typesLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            
            movesTitleLabel.topAnchor.constraint(equalTo: typesLabel.bottomAnchor, constant: 20),
            movesTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            
            movesLabel.topAnchor.constraint(equalTo: movesTitleLabel.bottomAnchor, constant: 8),
            movesLabel.leadingAnchor.constraint(equalTo: movesTitleLabel.leadingAnchor),
            movesLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            
            evolutionTitleLabel.topAnchor.constraint(equalTo: movesLabel.bottomAnchor, constant: 20),
            evolutionTitleLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            
            evolutionLabel.topAnchor.constraint(equalTo: evolutionTitleLabel.bottomAnchor, constant: 8),
            evolutionLabel.leadingAnchor.constraint(equalTo: evolutionTitleLabel.leadingAnchor),
            evolutionLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            evolutionLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -20),
            
            evolutionLabel.topAnchor.constraint(equalTo: evolutionTitleLabel.bottomAnchor, constant: 8),
            evolutionLabel.leadingAnchor.constraint(equalTo: evolutionTitleLabel.leadingAnchor),
            evolutionLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            evolutionLoader.centerYAnchor.constraint(equalTo: evolutionLabel.centerYAnchor),
            evolutionLoader.centerXAnchor.constraint(equalTo: evolutionLabel.centerXAnchor),
            evolutionLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadNetworkRequests() {
        evolutionLabel.text = nil
        evolutionLoader.startAnimating()
        
        viewModel.loadEvolutions()
        
        viewModel.onEvolutionLoaded = { [weak self] in
            guard let self else { return }
            let names = self.viewModel.evolutionNames.joined(separator: " → ")
            self.evolutionLabel.text = names
            self.evolutionLoader.stopAnimating()
        }
    }

    private func configure() {
        nameLabel.text = viewModel.name
        idLabel.text = viewModel.idText
        typesLabel.text = viewModel.typesText
        movesLabel.text = viewModel.movesText
        imageView.load(from: viewModel.imageURL)
    }
}

extension PokemonDetailViewController {
    private static func makeTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private static func makeDetailLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
