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
    
    mutating func animateLogo(refView: UIView , img: UIImageView , btn: UIButton) {
        let gravity = UIGravityBehavior(items: [img])
        let direction = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = direction
        animator = UIDynamicAnimator(referenceView: refView)
        let behavior = UIDynamicItemBehavior(items: [img])
        behavior.elasticity = 1
        behavior.resistance = 0
        behavior.allowsRotation = false
        let collision = UICollisionBehavior(items: [img])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionMode = UICollisionBehavior.Mode.everything
        let bumperPath = UIBezierPath(ovalIn: btn.frame)
        collision.addBoundary(withIdentifier: "bound" as NSCopying , for: bumperPath)
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(behavior)
    }
    
    func stopLogoAnimation() {
        animator.removeAllBehaviors()
    }
    
//    func detectIsLogin() {
//
//        if DataStore.shared.getStringPref("IS_LOGIN") == "1" {
//            coordinator.coordinateToTrackList()
//
//            let userDefaults = UserDefaults.standard
//
//            if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
//
//                let sessionDataObj = sessionObj as! Data
//                let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
//
//                if !firstTimeSession.isValid() {
//                    SPTAuth.defaultInstance()?.renewSession(firstTimeSession, callback: { error, newSession in
//                        if error != nil {
//                            print("error!")
//                        }
//                        if let newSession = newSession {
//                            let sessionData = NSKeyedArchiver.archivedData(withRootObject: newSession)
//                            DataStore.shared.saveEncodable(name: sessionData, key: "SpotifySession")
//                        }
//                    })
//
//                }
//            }
//        }
//    }
}
