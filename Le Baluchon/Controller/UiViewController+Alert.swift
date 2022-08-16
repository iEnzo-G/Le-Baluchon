//
//  UiViewController+Alert.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 16/08/2022.
//

import UIKit

extension UIViewController {
    private func presentAlert(message: String){
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
