//
//  ViewModel.swift
//  StateMachineTest
//
//  Created by Ashby Thornwell on 5/22/19.
//  Copyright © 2019 Ashby Thornwell. All rights reserved.
//

import UIKit
import Foundation

class NetworkingViewModel: NSObject {
    
    private let dataSource = NetworkDataSource()
    var delegate: ViewModelDisplayDelegate?
    
    override init() {
        
        super.init()
        
        dataSource.delegate = self
    }
    
    public func data() -> Any? {
        return dataSource.data
    }
    
    public func refresh() {
        dataSource.refresh()
    }
}

extension NetworkingViewModel: NetworkingDataSourceDelegate {
    func refreshedState(state: NetworkDataSource.State) {
        switch state {
        case .data:
            delegate?.displayData()
        case .empty:
            delegate?.displayEmpty()
        case .error:
            delegate?.displayError()
        default:
            break
        }
    }
}

