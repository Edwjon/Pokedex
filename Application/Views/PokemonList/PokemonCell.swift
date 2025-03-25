//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import UIKit

final class PokemonCell: UICollectionViewCell {
    static let identifier = "PokemonCell"
    private var currentPokemonID: Int?

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    func configure(with pokemon: Pokemon) {
        currentPokemonID = pokemon.id
        nameLabel.text = pokemon.name.capitalized
        imageView.image = nil
        
        let mainType = pokemon.types.first?.type.name ?? "normal"
        cardView.backgroundColor = PokemonTypeColorProvider.color(for: mainType).withAlphaComponent(0.3)

        guard let url = Endpoint.pokemonImage(id: pokemon.id).urlRequest?.url else {
            return
        }

        loadImageSafely(from: url, for: pokemon.id)
    }
    
    private func loadImageSafely(from url: URL, for id: Int) {
        Task { [weak self] in
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else { return }

                if self?.currentPokemonID == id {
                    self?.imageView.image = image
                }
            } catch {
                print("Error loading image")
            }
        }
    }
}
