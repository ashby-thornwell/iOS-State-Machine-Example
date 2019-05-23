//
//  DataSource.swift
//  StateMachineTest
//
//  Created by Ashby Thornwell on 5/22/19.
//  Copyright © 2019 Ashby Thornwell. All rights reserved.
//

import Foundation

/// The DataSource retains the data and vends it to the View Controller
public protocol DataSource: AnyObject {
    /// Does the data source contain no data
    var isEmpty: Bool { get }
}
