//
//  NetworkingDataSourceObserver.swift
//  StateMachineTest
//
//  Created by Ashby Thornwell on 5/23/19.
//  Copyright © 2019 Ashby Thornwell. All rights reserved.
//

import UIKit

protocol NetworkingDataSourceDelegate: AnyObject {
    func refreshedState(state: NetworkDataSource.State)
}

protocol ViewModelDisplayDelegate: AnyObject {
    func displayData()
    func displayError()
    func displayEmpty()
}
