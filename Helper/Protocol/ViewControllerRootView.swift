//
//  ViewControllerRootView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerRootView {
    
    associatedtype RootViewType
    
    var rootView: RootViewType { get }
}

public extension ViewControllerRootView where Self : UIViewController {
    
    var rootView: RootViewType {
        return self.view as! RootViewType
    }
}
