//
//  LoginViewModel.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import QuartzCore

struct LoginViewModel: ViewModel {
    
    let coordinator: LoginCoordinator
    private var animator: UIDynamicAnimator!
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
    mutating func animateLogo(refView: UIView , img: UIImageView) {
        let gravity = UIGravityBehavior(items: [img])
        let direction = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = direction
        animator = UIDynamicAnimator(referenceView: refView)
        let behavior = UIDynamicItemBehavior(items: [img])
        behavior.elasticity = 1
        behavior.resistance = 0.01
        let collision = UICollisionBehavior(items: [img])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionMode = UICollisionBehavior.Mode.everything
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(behavior)
    }
}
