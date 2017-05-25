//
//  ReverseGeocoding.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

extension UINib {
    static func objectWithClass(_ cls: AnyClass) -> AnyObject? {
        let nib = UINib.nibWithClass(cls)
        return nib?.objectWithClass(cls)
    }
    
    static func nibWithClass(_ cls: AnyClass) -> UINib? {
        return self.nibWithClass(cls, bundle: nil)
    }
    
    static func nibWithClass(_ cls: AnyClass, bundle: Bundle?) -> UINib? {
        return self.init(nibName: String(describing: cls.self), bundle: bundle)
    }
    
    func objectWithClass(_ cls: AnyClass) -> AnyObject? {
        return self.objectWithClass(cls, owner: nil)
    }
    
    func objectWithClass(_ cls: AnyClass, owner: AnyObject?) -> AnyObject? {
        return self.objectWithClass(cls, owner: owner, options: nil)
    }
    
    func objectWithClass(_ cls: AnyClass, owner: AnyObject?, options: NSDictionary?) -> AnyObject? {
        let objects = self.instantiate(withOwner: owner, options: (options as? [AnyHashable : Any]))
        for object in objects {
            if type(of: object) == cls.self {
                return object as AnyObject
            }
        }
        
        return nil
    }
  
}
