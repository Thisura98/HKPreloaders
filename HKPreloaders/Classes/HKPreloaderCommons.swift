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
    static func getBundle(forClass: AnyClass) -> Bundle{
        let podBundle = Bundle(for: forClass)
        let path = podBundle.path(forResource: "HKPreloaders", ofType: "bundle")! // The resource bundle
        return Bundle(path: path)!
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
