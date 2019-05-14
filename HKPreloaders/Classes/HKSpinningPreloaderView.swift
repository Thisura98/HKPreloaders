//
//  HKSpinningPreloaderView.swift
//  animchal
//
//  Created by Thisura on 5/11/19.
//  Copyright © 2019 thisura. All rights reserved.
//

import UIKit
import Foundation

fileprivate let ANIM_REPEAT_COUNT: Float = .greatestFiniteMagnitude
fileprivate let ANIM_DURATION: CFTimeInterval = 5.0
fileprivate let ANIM_ORB_DURATION: CFTimeInterval = ANIM_DURATION / 4.2
fileprivate let ANIM_ORB_SMALLEST_SCALE: CGFloat = 0.5
fileprivate let ANIM_ORB_LOWER_MIDWAY_SCALE: CGFloat = (1 - ANIM_ORB_SMALLEST_SCALE) * 0.25 + ANIM_ORB_SMALLEST_SCALE
fileprivate let ANIM_ORB_HIGHER_MIDWAY_SCALE: CGFloat = (1 - ANIM_ORB_SMALLEST_SCALE) * 0.75 + ANIM_ORB_SMALLEST_SCALE
fileprivate let ANIM_KEY_CONTAINER_ROTATE = "ak_container_r"
fileprivate let ANIM_KEY_ORB_SCALE = "ak_orb_s"

public class HKSpinningPreloaderView: UIView{
    
    @IBOutlet private weak var red: UIView!
    @IBOutlet private weak var orange: UIView!
    @IBOutlet private weak var yellow: UIView!
    @IBOutlet private weak var green: UIView!
    @IBOutlet private weak var container: UIView!
    
    private var orbRadius: CGFloat{
        get{
            return CGFloat(red.bounds.height) / 2
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
        let bundle = ResourceLoader.getBundleForNibs(forClass: HKSpinningPreloaderView.self)
        let nib = UINib(nibName: "HKSpinningPreloaderView", bundle: bundle)
        let loadedView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return loadedView
    }
    
    public func show(){
        
        // MARK: Setup for the animation
        
        let n1_8 = NSNumber(value: 1.0 / 8.0)
        let n3_8 = NSNumber(value: 3.0 / 8.0)
        let n5_8 = NSNumber(value: 5.0 / 8.0)
        let n7_8 = NSNumber(value: 7.0 / 8.0)
        
        let i = CATransform3DIdentity
        
        let smallestScaleTransform = CATransform3DScale(
            i,
            ANIM_ORB_SMALLEST_SCALE,
            ANIM_ORB_SMALLEST_SCALE,
            1)
        
        let lowerMidwayScaleTransform = CATransform3DScale(
            i,
            ANIM_ORB_LOWER_MIDWAY_SCALE,
            ANIM_ORB_LOWER_MIDWAY_SCALE,
            1)
        
        let higherMidwayScaleTransform = CATransform3DScale(
            i,
            ANIM_ORB_HIGHER_MIDWAY_SCALE,
            ANIM_ORB_HIGHER_MIDWAY_SCALE,
            1)
        
        red.clipsToBounds = true
        orange.clipsToBounds = true
        yellow.clipsToBounds = true
        green.clipsToBounds = true
        
        red.layer.cornerRadius = orbRadius
        red.layer.transform = higherMidwayScaleTransform
        
        orange.layer.cornerRadius = orbRadius
        orange.layer.transform = lowerMidwayScaleTransform
        
        yellow.layer.cornerRadius = orbRadius
        yellow.layer.transform = higherMidwayScaleTransform
        
        green.layer.cornerRadius = orbRadius
        green.layer.transform = lowerMidwayScaleTransform
        
        container.isHidden = false
        
        // MARK: Animations
        
        let c_r = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let r_s = CAKeyframeAnimation(keyPath: "transform")
        let o_s = CAKeyframeAnimation(keyPath: "transform")
        let y_s = CAKeyframeAnimation(keyPath: "transform")
        let g_s = CAKeyframeAnimation(keyPath: "transform")
        
        // MARK: Container rotation animation
        c_r.duration = ANIM_DURATION
        c_r.repeatCount = ANIM_REPEAT_COUNT
        c_r.keyTimes = [0.0, 0.5, 1.0]
        c_r.values = [
            0,
            CGFloat.pi,
            CGFloat.pi * 2.0
        ]
        
        // MARK: Red orb scale animation
        r_s.duration = ANIM_ORB_DURATION
        r_s.repeatCount = ANIM_REPEAT_COUNT
        r_s.keyTimes = [0.0, n3_8, n7_8, 1.0]
        r_s.values = [
            higherMidwayScaleTransform,
            smallestScaleTransform,
            i,
            higherMidwayScaleTransform
        ]
        
        // MARK: Orange orb scale animation
        o_s.duration = ANIM_ORB_DURATION
        o_s.repeatCount = ANIM_REPEAT_COUNT
        o_s.keyTimes = [0.0, n1_8, n5_8, 1.0]
        o_s.values = [
            lowerMidwayScaleTransform,
            smallestScaleTransform,
            i,
            lowerMidwayScaleTransform
        ]
        
        // MARK: Yellow orb scale animation
        y_s.duration = ANIM_ORB_DURATION
        y_s.repeatCount = ANIM_REPEAT_COUNT
        y_s.keyTimes = [0.0, n1_8, n5_8, 1.0]
        y_s.values = [
            higherMidwayScaleTransform,
            i,
            smallestScaleTransform,
            higherMidwayScaleTransform
        ]
        
        // MARK: Green orb scale animation
        g_s.duration = ANIM_ORB_DURATION
        g_s.repeatCount = ANIM_REPEAT_COUNT
        g_s.keyTimes = [0.0, n3_8, n7_8, 1.0]
        g_s.values = [
            lowerMidwayScaleTransform,
            i,
            smallestScaleTransform,
            lowerMidwayScaleTransform
        ]
        
        // MARK: Add animations to layers
        
        container.layer.add(c_r, forKey: ANIM_KEY_CONTAINER_ROTATE)
        red.layer.add(r_s, forKey: ANIM_KEY_ORB_SCALE)
        orange.layer.add(o_s, forKey: ANIM_KEY_ORB_SCALE)
        yellow.layer.add(y_s, forKey: ANIM_KEY_ORB_SCALE)
        green.layer.add(g_s, forKey: ANIM_KEY_ORB_SCALE)
        
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
