//
//  Manager.swift
//  XLProjectName
//
//  Created by XLAuthorName ( XLAuthorWebsite )
//  Copyright © 2016 XLOrganizationName. All rights reserved.
//

import Foundation
import Opera
import Alamofire
import KeychainAccess
import RxSwift

class NetworkManager: RxManager {

    static let singleton = NetworkManager(manager: Alamofire.Manager.sharedInstance)

    override init(manager: Alamofire.Manager) {
        super.init(manager: manager)
        observers = [Logger()]
    }

    override func rx_response(requestConvertible: URLRequestConvertible) -> Observable<OperaResult> {
        let response = super.rx_response(requestConvertible)
        return SessionController.sharedInstance.refreshToken().flatMap { _ in response }
    }
}

final class Route {}

struct Logger: Opera.ObserverType {
    func willSendRequest(alamoRequest: Alamofire.Request, requestConvertible: URLRequestConvertible) {
        debugPrint(alamoRequest)
    }
}
