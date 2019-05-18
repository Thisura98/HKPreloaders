//
//  ViewController.swift
//  HKPreloaders
//
//  Created by Thisura98 on 05/13/2019.
//  Copyright (c) 2019 Thisura98. All rights reserved.
//

import UIKit
import HKPreloaders

class ViewController: UIViewController {
    
    @IBOutlet private weak var spinningPreloader: HKSpinningPreloaderView!
    @IBOutlet private weak var morphingPreloader: HKMorphingPreloaderView!
    @IBOutlet private weak var animVisibilityBtn: UIButton!
    
    private var visibilityIsShown: Bool = true

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spinningPreloader.show()
        
        let c = HKPreloaderColorOptions(colors: [.purple, .cyan])
        morphingPreloader.mode = .Colors(colors: c)
        morphingPreloader.show()
    }
    
    @IBAction func animVisibilityBtnTapped(_ sender: UIButton){
        if visibilityIsShown{
            spinningPreloader.hide()
            morphingPreloader.hide()
        }
        else{
            spinningPreloader.show()
            morphingPreloader.show()
        }
        
        visibilityIsShown = !visibilityIsShown
    }

}

