//
//  NetworkReachabilityManager.swift
//  ProofOfConcept
//
//  Created by AshwiniT on 25/10/18.
//  Copyright © 2018 Ashwini Tangade. All rights reserved.
//

import Foundation
import Reachability

class NetworkReachabilityManager: NSObject {
    
    var reachability: Reachability!
    
    static let sharedInstance: NetworkReachabilityManager = { return NetworkReachabilityManager() }()
    
    
    override init() {
        super.init()
        
        reachability = Reachability()!
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
        print(notification)
    }
    
    static func stopNotifier() -> Void {
        do {
            try (NetworkReachabilityManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    static func isReachable(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection != .none {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    
    static func isUnreachable(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .none {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    
    static func isReachableViaWWAN(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
    
    static func isReachableViaWiFi(completed: @escaping (NetworkReachabilityManager) -> Void) {
        if (NetworkReachabilityManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkReachabilityManager.sharedInstance)
        }
    }
}
