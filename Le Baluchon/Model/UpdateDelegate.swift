//
//  UpdateDelegate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 30/08/2022.
//

import Foundation

// Communicate between Model and Controller
protocol UpdateDelegate: NSObject {
    func throwAlert(message: String)
    func updateUSDAmount(usd: String)
    func updateRateText(rate: String)
}
