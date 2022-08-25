//
//  SplashViewController.swift
//  Smarters Pro
//
//  Created by Keshav on 12/08/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            timer.invalidate()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChoosePlaylistViewController") as! ChoosePlaylistViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
