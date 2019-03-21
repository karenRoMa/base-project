//
//  LaunchScreenViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/20/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        // Load Lottie view
        let lottieView = AnimationView(name: "robot")
        lottieView.bounds = CGRect(x: 0, y: 0, width: animationView.bounds.width, height: animationView.bounds.height)
        lottieView.frame = animationView.bounds
        lottieView.clipsToBounds = true
        animationView.addSubview(lottieView)
        lottieView.loopMode = .loop
        lottieView.play()
        
    }

}
