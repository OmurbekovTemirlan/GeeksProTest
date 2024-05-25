//
//  PersonCollectionViewCell.swift
//  GeeksProTest
//
//  Created by Apple on 25.5.2024.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    static let reusID = "PersonCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 16, weight: .regular)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .lightGray
        layer.cornerRadius = 13
        imageView.layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setup() {
        setupAdd()
        setupLayouts()
    }
    
    private func setupAdd() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70)
        ])
    }
    
    func fill(with item: PersonDTO) {
        titleLabel.text = item.name
        ImageDownloader.shared.loadImage(from: item.image) { [weak self] result in
            guard let `self` = self else {return}
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
