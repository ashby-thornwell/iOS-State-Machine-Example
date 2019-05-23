//
//  DataSource.swift
//  StateMachineTest
//
//  Created by Ashby Thornwell on 5/21/19.
//  Copyright © 2019 Ashby Thornwell. All rights reserved.
//

import Foundation
import UIKit

final class NetworkDataSource: LoadableDataSource {
    
    // MARK: - Constants
        
    enum State: Int {
        case ready = 0
        case fetchData
        case data
        case empty
        case error
        case completed
    }
    
    // MARK: - Properties

    private var stateMachine: StateMachine<NetworkDataSource>!
    
    var data: Any?
    var delegate: NetworkingDataSourceDelegate?

    // MARK: - Initialization
    init() {
        stateMachine = StateMachine(initialState: .ready, delegate: self)
    }
    
    // MARK: - Base States
    
    func refresh() {
        stateMachine.state = .fetchData
    }
    
    func fetchData() {
        loadData { [weak self] result in
            switch result {
            case .success:
                self?.stateMachine.state = .data
            case .empty:
                self?.stateMachine.state = .empty
            case .failure(let error):
                print("Network State Machine error = \(error.localizedDescription)")
                self?.stateMachine.state = .error
            }
        }
    }
    
    func loadData(_ completion: @escaping ((LoadResult) -> Void)) {
        // Fetch Endpoint
        // Create Load Result
        let result = createLoadResult(error: nil, empty: false)
        completion(result)
    }
    
    var isEmpty: Bool {
        return data == nil
    }
    
    func refreshStateObserver(newState: NetworkDataSource.State) {
        delegate?.refreshedState(state: newState)
    }
}

// MARK: - State Machine Protocol

extension NetworkDataSource: StateMachineDelegateProtocol {
    
    func shouldTransition(from: State, to: State) -> Bool {
        // will set and did set
        guard from != .completed else {
            return false
        }
        
        return true 
    }
    
    func didTransition(from: NetworkDataSource.State, to: NetworkDataSource.State) {
        switch (from, to) {
        case (_, .fetchData):
            fetchData()
        case (_, .data):
            refreshStateObserver(newState: to)
        case (_, .error):
            refreshStateObserver(newState: to)
        case (_, .empty):
            refreshStateObserver(newState: to)
        default:
            break
        }
    }
}

