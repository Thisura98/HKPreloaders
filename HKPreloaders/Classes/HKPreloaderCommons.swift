//
//  HKPreloaderCommons.swift
//  animchal
//
//  Created by Thisura on 5/13/19.
//  Copyright © 2019 thisura. All rights reserved.
//

import UIKit
import Foundation

internal class ResourceLoader{
    
    /**
     Safely gets the correct bundle where
     nibs are stored at.
     
     This class was implemented because I couldn't get this pod
     to properly instantiate the UINib(s) when the pod's environment
     changes between development and production-use.
     
     The solution: If we find the nested-bundle 'HKPreloaders' (generated
     by the podspec, as the Resource Bundle) return it. This means the pod
     is in a production-use environment. Otherwise, return the podBundle itself.
     
     - parameters:
        - forClass: The class used to search for the top-level bundle
     */
    
    static func getBundleForNibs(forClass: AnyClass) -> Bundle{
        let podBundle = Bundle(for: forClass)
        if let path = podBundle.path(forResource: "HKPreloaders", ofType: "bundle"){
            return Bundle(path: path)!  // The resource bundle
        }
        return podBundle
    }
}

enum HKPreloaderViewSize{
    case defaultSize
    case small
    case medium
    case large
    case custom(CGSize)
    
    func size() -> CGSize{
        switch(self){
        case .small:
            return CGSize(width: 20.0, height: 20.0)
        case .defaultSize, .medium:
            return CGSize(width: 100.0, height: 100.0)
        case .large:
            return CGSize(width: 160.0, height: 160.0)
        case .custom(let s):
            return s
        }
    }
}

enum HKPreloaderBackgroundColor{
    case clear
    case custom(UIColor)
    
    func color() -> UIColor{
        switch(self){
        case .clear:
            return .clear
        case .custom(let c):
            return c
        }
    }
}

enum HKPreloaderHideMethod{
    case immediate
    case fade
}

enum HKPreloaderDefaultVisibility{
    case show(size: HKPreloaderViewSize?, background: HKPreloaderBackgroundColor?)
    case hide
}

protocol HKPreloaderView{
    static func add(to: UIView, visibility: HKPreloaderDefaultVisibility)
    func show(size: HKPreloaderViewSize?, background: HKPreloaderBackgroundColor?)
    func hide(anim: HKPreloaderHideMethod?)
}
