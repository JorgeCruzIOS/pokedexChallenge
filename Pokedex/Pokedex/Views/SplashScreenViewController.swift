//
//  SplashScreen.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController{
    
    lazy var pokedexLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.attributedText = "POKEDEX".decorative(color: .black, font: .systemFont(ofSize: 40, weight: .bold))
        return lb
    }()
    
    lazy var lottiLoader: AnimationView = {
        let animation = Animation.named("loadingLottie",
                                        bundle: .main,
                                        subdirectory: nil,
                                        animationCache: nil)

        let lottie = AnimationView(animation: animation)
        lottie.contentMode = .scaleAspectFit
        lottie.backgroundBehavior = .pauseAndRestore
        lottie.loopMode = .loop
        lottie.play()
        lottie.translatesAutoresizingMaskIntoConstraints = false
        return lottie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lottiLoader)
        view.addSubview(pokedexLabel)
        NSLayoutConstraint.activate([
            lottiLoader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottiLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottiLoader.heightAnchor.constraint(equalToConstant: 150),
            
            pokedexLabel.topAnchor.constraint(equalTo: lottiLoader.bottomAnchor, constant: 20),
            pokedexLabel.centerXAnchor.constraint(equalTo: lottiLoader.centerXAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.navigationController?.pushViewController(ListPokemonViewController(), animated: true)
        })
    }
}
