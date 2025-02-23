//
//  VPNController.swift
//  Bounce
//
//  Created by Nick on 2/19/25.
//
import Foundation
import Combine

class VPNController: ObservableObject {
    @Published var vpnProfileIsInstalled : Bool
    @Published var vpnIsStarted : Bool
    var configService : VPNConfigurationManager = .shared
    
    init() {
        self.vpnProfileIsInstalled = configService.isProfileInstalled
        self.vpnIsStarted = configService.isStarted
    }
    
    func installVPNProfile() {
        configService.installVPNProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.vpnProfileIsInstalled = true
                case .failure(let error):
                    // Handle error as needed
                    print("Error installing VPN profile: \(error)")
                }
            }
        }
    }
    
    func removeVPNProfile() {
        configService.removeVPNProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.vpnProfileIsInstalled = false
                case .failure(let error):
                    print("Error installing VPN profile: \(error)")
                }
            }
        }
    }
    
    func toggleVPNProfileInstallation() {
        if self.vpnProfileIsInstalled {
            self.removeVPNProfile()
        } else {
            self.installVPNProfile()
        }
    }
    
}
