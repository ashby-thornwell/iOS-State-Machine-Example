//
//  LoadableDataSource.swift
//  StateMachineTest
//
//  Created by Ashby Thornwell on 5/22/19.
//  Copyright © 2019 Ashby Thornwell. All rights reserved.
//

import Foundation

public enum LoadResult {
    /// Data has been successfully loaded
    case success
    /// Successful response, but no data available
    case empty
    /// Something went wrong, consult Error for details
    case failure(_ error: Error)
}

public protocol LoadableDataSource: DataSource {
    func loadData(_ completion: @escaping ((LoadResult) -> Void))
}

public extension LoadableDataSource {
    
    /// A Helper method that wraps the common logic around determing the LoadResult state after
    /// a load has completed.
    ///
    /// - Parameters:
    ///   - error: An optional Error returned by the API or other source
    ///   - empty: Whether or not the data is empty, usually the result of self.isEmpty()
    func createLoadResult(error: Error?, empty: Bool) -> LoadResult {
        if let error = error {
            // An error has been returned, set state to failure
            return .failure(error)
        } else {
            // Check if empty, otherwise return success
            return empty ? .empty : .success
        }
    }
    
}
