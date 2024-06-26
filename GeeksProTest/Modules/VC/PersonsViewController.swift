//
//  ViewController.swift
//  GeeksProTest
//
//  Created by Apple on 25.5.2024.
//

import UIKit

class PersonsViewController: BaseViewController {
    
    private let personCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.itemSize = CGSize(width: 350, height: 70)
        loyaut.minimumLineSpacing = 10
        loyaut.minimumInteritemSpacing = 10
        loyaut.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        loyaut.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var persons: [PersonDTO] = []
    
    private let networkSertvice = NetworkService()
    
    private var selectedCategory: PersonDTO?
    
    override func setup() {
        setupAdd()
        setupLayouts()
        setupCollection()
        getPersons()
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(personCollectionView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        NSLayoutConstraint.activate([
            
        personCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
        personCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        personCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        personCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        
        ])
    }
    
    private func setupCollection() {
        personCollectionView.dataSource = self
        personCollectionView.delegate = self
        personCollectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.reusID)
    }
    
    private func getPersons() {
        networkSertvice.getPersons { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {return}
                switch result {
                case .success(let model):
                    self.persons = model
                    self.personCollectionView.reloadData()
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func handlePersonDetailsTap(with person: PersonDTO) {
        let detailVC = PersonDetailsViewController()
        detailVC.selectedProduct = person.id
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

extension PersonsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.reusID, for: indexPath) as! PersonCollectionViewCell
        cell.fill(with: persons[indexPath.row])
        return cell
    }
}

extension PersonsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handlePersonDetailsTap(with: persons[indexPath.row])
    }
}
