//
//  ListPokemonPDF.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import UIKit

class ListPokemonPDF: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ItemPokemonViewCellDelegate {
    var pkmViewModel: [PokemonVM]?
    lazy var listPokemonTV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let collertion = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collertion.showsVerticalScrollIndicator = false
        collertion.delegate = self
        collertion.backgroundColor = UIColor.clear
        collertion.dataSource = self
        collertion.register(ItemPokemonViewCell.self, forCellWithReuseIdentifier: "ItemPokemonViewCell")
        collertion.translatesAutoresizingMaskIntoConstraints = false
        return collertion
    }()
    
    
    @objc init(pkmViewModel: [PokemonVM]?) {
        self.pkmViewModel = pkmViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        buildConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func buildUI() {
        view.backgroundColor = UIColor(red: 245.0/256.0, green: 246.0/256.0, blue: 248.0/256.0, alpha: 1)
        view.addSubview(listPokemonTV)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            listPokemonTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listPokemonTV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            listPokemonTV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            listPokemonTV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pkmViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itempokemon = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPokemonViewCell", for: indexPath) as? ItemPokemonViewCell else {
            return UICollectionViewCell()
        }
        
        if let pokemon = pkmViewModel?[indexPath.row] {
            itempokemon.buildData(pokemon)
        }
        
        return itempokemon
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: cellWidth, height: 120)
    }
    
    func notifyItemSelected(_ pokemonVM: PokemonVM) {}
}
