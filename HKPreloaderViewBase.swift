//
//  HKPreloaderViewBase.swift
//  HKPreloaders
//
//  Created by Thisura on 5/18/19.
//

import UIKit
import Foundation

/**
 Base class for all HKPreloader views
 */
public class HKPreloaderViewBase: UIView{
    
    @IBOutlet internal weak var red: UIView!
    @IBOutlet internal weak var orange: UIView!
    @IBOutlet internal weak var yellow: UIView!
    @IBOutlet internal weak var green: UIView!
    @IBOutlet internal weak var container: UIView!
    
    internal var view: UIView!
    internal var orbRadius: NSNumber{
        get{
            let radius = NSNumber(value: Float(red.bounds.height) / 2.0)
            print("DEBUG: Returning orb radius: \(radius)")
            return radius
        }
    }
    
    /// The speed of the animation loop, default is 1.5 seconds.
    @IBInspectable public var animationSpeed: CFTimeInterval = 1.5
    
    /// The mode (color/images) to use; default is a four color array.
    ///
    /// All colors/images are in __clockwise__ order, starting from the
    /// first orb (which is by default, red in color and is located on the
    /// top-left)
    public var mode: HKPreloaderMode = HKPreloaderDefaultOptions.mode
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    /// Performs post-initialization for a newly
    /// created HKPreloader
    final private func internalInit(){
        view = loadViewFromNib()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        backgroundColor = .clear
        hide()
    }
    
    /// Locates the nib file from the bundle and instantiates
    /// it with this class. Returns the loaded view from the nib.
    final private func loadViewFromNib() -> UIView{
        let bundle = ResourceLoader.getBundleForNibs(forClass: HKMorphingPreloaderView.self)
        let nib = UINib(nibName: "HKMorphingPreloaderView", bundle: bundle)
        let loadedView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return loadedView
    }
    
    // Overriding Guide:
    // Override this method in a sub class to expose 'showing' functionality
    public func show(){
        fatalError("HKPreloaderViewBase: This method must be overriden by a sub class AND must no be called via super.show()")
    }
    
    // Overriding Guide:
    // Override this method in a sub class to expose 'hiding' functionality
    public func hide(){
        fatalError("HKPreloaderViewBase: This method must be overriden by a sub class AND must no be called via super.hide()")
    }
    
    // Override Guide:
    // Override this method to provide additional setup for orbs,
    // remember to call the super method at some point.
    
    /// Sets the color/images of the orbs using the mode variable.
    /// Is usually called from inside the show() method to setup the
    /// look of the orbs.
    
    internal func setupOrbsAccordingToMode(){
        red.clipsToBounds = true
        orange.clipsToBounds = true
        green.clipsToBounds = true
        yellow.clipsToBounds = true
        
        switch(mode){
        case .Colors(colors: let co):
            red.backgroundColor = co.orbColors[0]
            orange.backgroundColor = co.orbColors[1]
            yellow.backgroundColor = co.orbColors[2]
            green.backgroundColor = co.orbColors[3]
        default:
            fatalError("HKPreloaderViewBase: Mode not implemented yet")
        }
    }
    
}
