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

// For future use
/*enum HKPreloaderViewSize{
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
}*/

/**
 A type that holds the color information for an
 HKPreloader in a __clockwise order, starting from orb 1__
 (which is by default, red)
 */
final public class HKPreloaderColorOptions{
    
    internal var orbColors: [UIColor] = []
    
    /**
     Creates a color array for an HKPreloader to use.
     
     The colors are assumed to be in clockwise order starting from
     the first orb (by default, red orb).
     
     A maximum of 4 and a minimum of 1 colors can be provided.
     However, 4 colors are required to load an HKPreloader so
     the remaining empty color slots will be filled with the
     repeating pattern of the color array.
     
     For example if only 3 colors are provided the resulting
     color array will look like this:
     ```
     colorArray = [c1, c2, c3, c1]
     ```
     
     - parameters:
        - colors: An array of colors to use
     */
    public init(colors: [UIColor]){
        assert(colors.count <= 4, "HKPreloaderColorOptions: Only a maximum of 4 colors can be displayed.")
        assert(colors.count > 0, "HKPreloaderColorOptions: Colors array was empty. Atleast one color must be supplied.")
        
        switch(colors.count){
        case 1:
            let c = colors[0]
            orbColors = [c, c, c, c]
        case 2:
            let c1 = colors[0]
            let c2 = colors[1]
            orbColors = [c1, c2, c1, c2]
        case 3:
            let c1 = colors[0]
            let c2 = colors[1]
            let c3 = colors[2]
            orbColors = [c1, c2, c3, c1]
        default:
            orbColors = colors
        }
    }
}

/**
 A type that holds the image information for an
 HKPreloader in a __clockwise order, starting from orb 1__
 (which is by default, red)
 */
final public class HKPreloaderImageOptions{
    
    internal var orbImages: [UIImage] = []
    /**
     Creates an image array for an HKPreloader to use.
     
     The images are assumed to be in clockwise order starting from
     the first orb (by default, red orb).
     
     A maximum of 4 and a minimum of 1 image can be provided.
     However, 4 images are required to load an HKPreloader so
     the remaining empty image slots will be filled with the
     repeating pattern of the image array.
     
     For example if only 3 images are provided the resulting
     image array will look like this:
     ```
     imageArray = [i1, i2, i3, i1]
     ```
     
     - parameters:
        - images: An array of images to use
     */
    public init(images: [UIImage]){
        assert(images.count > 4, "HKPreloaderColorOptions: Only a maximum of 4 images can be displayed.")
        assert(images.count > 0, "HKPreloaderColorOptions: Images array was empty. Atleast one image must be supplied.")
        
        switch(images.count){
        case 1:
            let i = images[0]
            orbImages = [i, i, i, i]
        case 2:
            let i1 = images[0]
            let i2 = images[1]
            orbImages = [i1, i2, i1, i2]
        case 3:
            let i1 = images[0]
            let i2 = images[1]
            let i3 = images[2]
            orbImages = [i1, i2, i3, i1]
        default:
            orbImages = images
        }
    }
}

public enum HKPreloaderMode{
    case Colors(colors: HKPreloaderColorOptions)
    case Images(images: HKPreloaderImageOptions)
}

final internal class HKPreloaderDefaultOptions{
    static let mode = HKPreloaderMode.Colors(colors: HKPreloaderColorOptions(colors: [.red, .orange, .yellow, .green]))
    static let animationSpeed: CFTimeInterval = 1.5
}
