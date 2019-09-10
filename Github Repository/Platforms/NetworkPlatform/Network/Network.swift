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

final class Network<T, E> where E: TargetType, T: Decodable {
    
    private let networkProvider: MoyaProvider<E> = MoyaProvider<E>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getItems(_ endPoint: E) -> Observable<[T]> {
        
        return networkProvider
            .rx
            .request(endPoint)
            .catchPhotosError(PhotosError.self)
            .debug("Endpoint: \(endPoint.baseURL)\(endPoint.path)")
            .asObservable()
            .map([T].self)
    }
    
    func getItem(_ endPoint: E) -> Observable<T> {
        return networkProvider
            .rx
            .request(endPoint)
            .catchPhotosError(PhotosError.self)
            .debug("Endpoint: \(endPoint.baseURL)\(endPoint.path)")
            .asObservable()
            .map(T.self)
    }
    
}

extension PrimitiveSequence where TraitType == SingleTrait, Element == Response {
    
    func catchPhotosError(_ type: PhotosError.Type) -> Single<ElementType> {
        return flatMap { response in
            
            guard(200...299).contains(response.statusCode) else {
                do {
                    var photosErrorResponse = try response.map(type.self)
                    photosErrorResponse.statusCode = response.statusCode
                    throw photosErrorResponse
                } catch {
                    throw error
                }
            }
            
            return .just(response)
        }
    }
    
}

extension ObservableType where E: EventConvertible {

    public func photoErrors() -> Observable<PhotosError> {
        return filter { $0.event.error != nil }
            .map { $0.event.error as! PhotosError }
    }
}
