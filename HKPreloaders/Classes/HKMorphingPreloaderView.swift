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
fileprivate let ANIM_KEY_CONTAINER_OPACITY = "ak_container_op"
fileprivate let ANIM_KEY_ORB_BORDER_RADIUS = "ak_orb_bord"

public class HKMorphingPreloaderView: HKPreloaderViewBase{
    
    override public func show(){
        
        // MARK: Setup for the animation
        
        self.setupOrbsAccordingToMode()
        
        container.layer.opacity = 0.0
        container.isHidden = false
        
        // MARK: Animations
        
        let c_o = CAKeyframeAnimation(keyPath: "opacity")
        let o_b = CAKeyframeAnimation(keyPath: "cornerRadius")
        
        // MARK: Container opacity animation
        c_o.duration = animationSpeed
        c_o.repeatCount = ANIM_REPEAT_COUNT
        c_o.keyTimes = [0.0, 0.2, 0.55, 0.95]
        c_o.values = [0.0, 1.0, 1.0, 0.0]
        
        // MARK: Border radius animation
        o_b.duration = animationSpeed
        o_b.repeatCount = ANIM_REPEAT_COUNT
        o_b.keyTimes = [0.0, 0.2, 0.55, 0.75]
        o_b.values = [0.0, orbRadius, orbRadius, 0.0]
        o_b.tensionValues = [0.0, 1.0, 1.0, 0.0]
        o_b.calculationMode = .cubic
        
        // MARK: Add animations to layers
        
        container.layer.add(c_o, forKey: ANIM_KEY_CONTAINER_OPACITY)
        red.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        orange.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        green.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        yellow.layer.add(o_b, forKey: ANIM_KEY_ORB_BORDER_RADIUS)
        
    }
    
    override public func hide(){
        
        container.layer.removeAllAnimations()
        red.layer.removeAllAnimations()
        orange.layer.removeAllAnimations()
        green.layer.removeAllAnimations()
        yellow.layer.removeAllAnimations()
        container.isHidden = true
    }
    
}
