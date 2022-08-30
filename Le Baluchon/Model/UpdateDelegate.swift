//
//  UpdateDelegate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 30/08/2022.
//

import Foundation

protocol UpdateDelegate: NSObject {
    func throwAlert(message: String)
    func updateScreen(calculText: String)
}
