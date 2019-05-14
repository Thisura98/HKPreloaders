//
//  HKMorphingPreloaderView.swift
//  animchal
//
//  Created by Thisura on 5/11/19.
//  Copyright © 2019 thisura. All rights reserved.
//

import UIKit
import Foundation

fileprivate let ANIM_REPEAT_COUNT: Float = .greatestFiniteMagnitude
fileprivate let ANIM_DURATION: CFTimeInterval = 1.5
fileprivate let ANIM_KEY_CONTAINER_OPACITY = "ak_container_op"
fileprivate let ANIM_KEY_ORB_BORDER_RADIUS = "ak_orb_bord"

public class HKMorphingPreloaderView: UIView{
    
    @IBOutlet private weak var red: UIView!
    @IBOutlet private weak var orange: UIView!
    @IBOutlet private weak var yellow: UIView!
    @IBOutlet private weak var green: UIView!
    @IBOutlet private weak var container: UIView!
    
    private var orbRadius: NSNumber{
        get{
            return NSNumber(value: Float(red.bounds.height) / 2.3)
        }
    }
    
    private var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    private func internalInit(){
        view = loadViewFromNib()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        backgroundColor = .clear
        hide()
    }
    
    private func loadViewFromNib() -> UIView{
        let bundle = ResourceLoader.getBundleForNibs(forClass: HKMorphingPreloaderView.self)
        let nib = UINib(nibName: "HKMorphingPreloaderView", bundle: bundle)
        let loadedView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return loadedView
    }
    
    public func show(){
        
        // MARK: Setup for the animation
        
        container.layer.opacity = 0.0
        container.isHidden = false
        
        red.clipsToBounds = true
        orange.clipsToBounds = true
        green.clipsToBounds = true
        yellow.clipsToBounds = true
        
        // MARK: Animations
        
        let c_o = CAKeyframeAnimation(keyPath: "opacity")
        let o_b = CAKeyframeAnimation(keyPath: "cornerRadius")
        
        // MARK: Container opacity animation
        c_o.duration = ANIM_DURATION
        c_o.repeatCount = ANIM_REPEAT_COUNT
        c_o.keyTimes = [0.0, 0.2, 0.55, 0.95]
        c_o.values = [0.0, 1.0, 1.0, 0.0]
        
        // MARK: Border radius animation
        o_b.duration = ANIM_DURATION
        o_b.repeatCount = ANIM_REPEAT_COUNT
        o_b.keyTimes = [0.0, 0.2, 0.55, 0.75]
        o_b.values = [0.0, orbRadius, orbRadius, 0.0]
        o_b.calculationMode = .cubic
        
        // MARK: Add animations to layers
        
        container.layer.add(c_o, forKey: ANIM_KEY_CONTAINER_OPACITY)
        red.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        orange.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        green.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        yellow.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        
    }
    
    public func hide(){
        
        container.layer.removeAllAnimations()
        red.layer.removeAllAnimations()
        orange.layer.removeAllAnimations()
        green.layer.removeAllAnimations()
        yellow.layer.removeAllAnimations()
        container.isHidden = true
    }
    
}
