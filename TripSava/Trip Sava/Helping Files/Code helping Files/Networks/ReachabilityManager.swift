//
//  ReachabilityManager.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 26/07/2023.
//

import Foundation
import Reachability

protocol ReachabilityManagerDelegate: AnyObject {
    func networkStatusDidChange(isReachable: Bool)
}

class ReachabilityManager {
    static let shared = ReachabilityManager()
    private var reachability: Reachability?

    weak var delegate: ReachabilityManagerDelegate?

    private init() {
        reachability = try? Reachability()
        startMonitoring()
    }

    func startMonitoring() {
        guard let reachability = reachability else { return }
        do {
            try reachability.startNotifier()
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: reachability)
        } catch {
            print("Error starting reachability notifier.")
        }
    }

    func stopMonitoring() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    var isReachable: Bool {
        guard let reachability = reachability else { return false }
        return reachability.connection != .unavailable
    }

    @objc private func reachabilityChanged(notification: Notification) {
        if let reachability = notification.object as? Reachability {
            let isReachable = reachability.connection != .unavailable
            delegate?.networkStatusDidChange(isReachable: isReachable)
        }
    }
}
