//
//  DetailPokemonViewController.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    let viewContainer = UIView(frame: .zero)
    let pokemonBackground = UIView(frame: .zero)
    let shadowViewContainer = UIView(frame: .zero)
    let mainContainer = UIScrollView(frame: .zero)
    lazy var pokemonImage: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    lazy var nameLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    lazy var baseEpxLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var heightLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var weightLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var boxTypoStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    lazy var boxAbilitiesStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    
    private var pokemonListDetailVM: ListPokemonDetailVM
    
    @objc init(pokemonvm: PokemonVM) {
        self.pokemonListDetailVM = ListPokemonDetailVM(pokemonVM: pokemonvm)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        buildUI()
        buildConstraints()
        LoadingManager.shared.showLoading()
        pokemonListDetailVM.loadListPokemon {
            let fetch = self.pokemonListDetailVM.fetchPokemonDetailVM()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                LoadingManager.shared.dismissLoading()
                self.baseEpxLabel.attributedText = fetch?.pkmBaseExp
                self.baseEpxLabel.textAlignment = .right
                self.weightLabel.attributedText = fetch?.pkmWeight
                self.weightLabel.textAlignment = .center
                self.heightLabel.attributedText = fetch?.pkmHeight
                self.heightLabel.textAlignment = .center
                self.pokemonBackground.backgroundColor = fetch?.pkmBackground
                self.boxTypoStack.arrangedSubviews.forEach { e in
                    e.removeFromSuperview()
                }
                fetch?.pkmTypo.forEach({ typo in
                    let button = UIButton(frame: .zero)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.setTitle(typo.rawValue.capitalized, for: .normal)
                    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
                    button.setTitleColor(typo.fetchColorText(), for: .normal)
                    button.backgroundColor = typo.fetchColor()
                    button.layer.cornerRadius = 13
                    NSLayoutConstraint.activate([
                        button.heightAnchor.constraint(equalToConstant: 26),
                        button.widthAnchor.constraint(equalToConstant: 100)
                    ])
                    self.boxTypoStack.addArrangedSubview(button)
                })
                self.boxAbilitiesStack.arrangedSubviews.forEach { e in
                    e.removeFromSuperview()
                }
                if let abilities = fetch?.pkmAbilities, abilities.count > 0 {
                    let abilityLabel = UILabel()
                    abilityLabel.translatesAutoresizingMaskIntoConstraints = false
                    abilityLabel.font = .systemFont(ofSize: 22, weight: .semibold)
                    abilityLabel.text = "Abilities"
                    self.boxAbilitiesStack.addArrangedSubview(abilityLabel)
                    
                    abilities.forEach { effect in
                        let abilityLabel = UILabel()
                        abilityLabel.translatesAutoresizingMaskIntoConstraints = false
                        abilityLabel.numberOfLines = 0
                        abilityLabel.attributedText = effect.pkmEffect
                        self.boxAbilitiesStack.addArrangedSubview(abilityLabel)
                    }
                }
            }
        )}
        
    }

    
    func buildUI(){
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        pokemonBackground.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.backgroundColor = .white
        shadowViewContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowViewContainer.layer.cornerRadius = 35
        shadowViewContainer.backgroundColor = .white
        view.addSubview(pokemonBackground)
        view.addSubview(mainContainer)
        mainContainer.addSubview(shadowViewContainer)
        mainContainer.addSubview(viewContainer)
        mainContainer.addSubview(pokemonImage)
        
        viewContainer.addSubview(boxTypoStack)
        viewContainer.addSubview(boxAbilitiesStack)
        viewContainer.addSubview(nameLabel)
        viewContainer.addSubview(baseEpxLabel)
        viewContainer.addSubview(heightLabel)
        viewContainer.addSubview(weightLabel)
        
        if let vmitem = pokemonListDetailVM.fetchPokemonDetailVM(){
            pokemonImage.image = UIImage(data: vmitem.pkmImage)
            nameLabel.attributedText = vmitem.pkmNameNumber
        }
        
    }
    
    func buildConstraints(){
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            pokemonBackground.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonBackground.widthAnchor.constraint(equalTo: view.widthAnchor),
            pokemonBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonBackground.bottomAnchor.constraint(equalTo: mainContainer.centerYAnchor),
            
            pokemonImage.heightAnchor.constraint(equalTo: mainContainer.widthAnchor, multiplier: 0.4),
            pokemonImage.widthAnchor.constraint(equalTo: pokemonImage.heightAnchor),
            pokemonImage.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor),
            pokemonImage.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 10),
            
            viewContainer.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor),
            viewContainer.widthAnchor.constraint(equalTo: mainContainer.widthAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: 20),
            
            shadowViewContainer.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: -40),
            shadowViewContainer.heightAnchor.constraint(equalToConstant: 100),
            shadowViewContainer.widthAnchor.constraint(equalTo: viewContainer.widthAnchor),
            
            boxTypoStack.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor),
            boxTypoStack.centerXAnchor.constraint(equalTo: pokemonImage.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: boxTypoStack.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20),
            
            baseEpxLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            baseEpxLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20),
            
            heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            heightLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor, constant: -100),
            
            weightLabel.topAnchor.constraint(equalTo: baseEpxLabel.bottomAnchor, constant: 40),
            weightLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor, constant: 100),
            
            boxAbilitiesStack.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 30),
            boxAbilitiesStack.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20),
            boxAbilitiesStack.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20),
            boxAbilitiesStack.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -50)
            
        ])
    }
}
