//
//  NetworkProvider.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift
import Moya

final class Network<T: Decodable, O: TargetType> {
    
    private let networkProvider: MoyaProvider<O> = MoyaProvider<O>()
    
    func getItems(_ endPoint: O) -> Observable<[T]> {
        return networkProvider
            .rx
            .request(endPoint)
            .debug("Endpoint: \(endPoint.baseURL)\(endPoint.path)")
            .asObservable()
            .map([T].self)
    }
}
