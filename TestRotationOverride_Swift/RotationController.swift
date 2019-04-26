//
//  RotationController.swift
//  TestRotationOverride_Swift
//
//  Created by Amitai Blickstein on 4/25/19.
//  Copyright © 2019 Amitai Blickstein. All rights reserved.
//

import UIKit

protocol OrientationLockDelegate {
    func lock()
    func unlock()
    var  isUnlocked: Bool { get }
    var  _landscapeAllowed: Bool { get }
}


/// Use this class to inform the AppDelegate about orientation preferences at runtime.
class RotationController: OrientationLockDelegate {
    // Singleton pattern makes sense, as there is only one device screen,
    // that can only be oriented in one way at a time.
    static var shared = RotationController()
    private init() {}
    
    func lock() {
        _landscapeAllowed = false
    }
    
    func unlock() {
        _landscapeAllowed = true
    }
    
    var isUnlocked: Bool
    {
        set { newValue ? unlock() : lock() }
        get { return _landscapeAllowed }
    }
    
    /// Initial value reflects the Info.plist value, if detected. Defaults to false.
    var _landscapeAllowed: Bool = {
        guard let supportedOrientations = Bundle.main.object(forInfoDictionaryKey: "UISupportedInterfaceOrientations") as? [String]
            else { return false }

        // Either should return "true":
        //        UIInterfaceOrientationLandscapeLeft
        //        UIInterfaceOrientationLandscapeRight
        return supportedOrientations.contains { $0.contains("LandScape") }
    }()
}
