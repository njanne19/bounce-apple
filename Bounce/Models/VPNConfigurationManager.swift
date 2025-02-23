//
//  VPNConfigurationManager.swift
//  Bounce
//
//  Created by Nick on 2/22/25.
//

import Foundation
import Combine
import NetworkExtension

final class VPNConfigurationManager {
    private(set) var tunnelManager: NETunnelProviderManager? // ? means can be nil
    static let shared = VPNConfigurationManager() // singleton
    
    private(set) var isStarted = false { didSet { notifyVPNManagerDidUpdate()}}
    private(set) var isProfileInstalled = false { didSet {notifyVPNManagerDidUpdate()}}
    
    private func notifyVPNManagerDidUpdate() {
        NotificationCenter.default.post(name: .vpnManagerDidUpdate, object: self)
    }
    
    private func makeTunnelProviderManager() -> NETunnelProviderManager {
        
        // First we create a new instance of NETunnelProvider Manager
        // we also give it a quick name
        let manager = NETunnelProviderManager()
        manager.localizedDescription = "Bounce VPN"
        
        // Then we need to configure the protocol, which is the underlying
        // set of params for the VPN tunnel:
        let tunnelProtocol = NETunnelProviderProtocol()
        tunnelProtocol.providerBundleIdentifier = "com.nickjanne.Bounce.Bounce-Extension"
        
        tunnelProtocol.providerConfiguration = [:] // Could be used for additional options later.
        
        tunnelProtocol.serverAddress = "127.0.0.1:4009" // VPN server, going to be a test in this case
        
        // We'll do nothing else for now.
        manager.protocolConfiguration = tunnelProtocol
        
        // Enable the manager by default
        manager.isEnabled = true
        
        return manager
    }
    
    
    func installVPNProfile(_ completion: @escaping (Result<Void, Error>) -> Void) {
        let manager = makeTunnelProviderManager()
        manager.saveToPreferences { [weak self] error in
            if let error = error {
                return completion(.failure(error))
            }
            
            manager.loadFromPreferences { [weak self] error in
                self?.tunnelManager = manager
                self?.isProfileInstalled = true
                completion(.success(()))
            }
        }
        
    }
    
    func removeVPNProfile(_ completion: @escaping (Result<Void, Error>) -> Void) {
        assert(self.tunnelManager != nil, "VPN profile not installed")
        self.tunnelManager?.removeFromPreferences { [weak self] error in
            if let error = error {
                return completion(.failure(error))
            }
            self?.tunnelManager = nil
            self?.isProfileInstalled = false
            completion(.success(()))
        }
    }
    
}

extension Notification.Name {
    static let vpnManagerDidUpdate = Notification.Name("vpnManagerDidUpdate")
}
