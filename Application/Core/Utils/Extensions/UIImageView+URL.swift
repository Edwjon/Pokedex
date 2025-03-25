//
//  UIImageView+URL.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import UIKit

extension UIImageView {
    func load(from url: URL?) {
        guard let url = url else {
            Task { @MainActor in
                self.image = nil
            }
            return
        }

        let cacheKey = url.absoluteString

        if let cached = ImageCache.shared.get(forKey: cacheKey) {
            Task { @MainActor in
                self.image = cached
            }
            return
        }

        Task.detached(priority: .background) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    ImageCache.shared.set(image, forKey: cacheKey)
                    await MainActor.run {
                        self.image = image
                    }
                }
            } catch {
                await MainActor.run {
                    self.image = nil
                }
            }
        }
    }
}

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
