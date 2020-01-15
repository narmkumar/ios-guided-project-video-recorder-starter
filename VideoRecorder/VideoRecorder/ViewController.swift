//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
        requestPermissionAndShowCamera()
		
	}
    
    private func requestPermissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
            
        case .notDetermined:
            // First time user - they haven't seen teh dialog to give permission
            requestPermission()
        case .restricted:
            // Parental controls disabled the camera
            fatalError("Video is dsaled for the user (parental controls)")
            // TODO: Add UI to inform the user (talk to parents)
        case .denied:
            //User did not give us access (maybe it was an accident)
            fatalError("Tell the user they need to enabe Privacy for videos")
        case .authorized:
            // we asked for permission (2nd time they've used the app)
            showCamera()
        @unknown default:
            fatalError("A new status was added that we need to handle")
        }
    }
    
    private func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("Tell user they need to enable Privacy for Video")
            }
            DispatchQueue.main.async { [weak self] in
                self?.showCamera()
            }
        }
    }
	
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
