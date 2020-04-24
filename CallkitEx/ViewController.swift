//
//  ViewController.swift
//  CallkitEx
//
//  Created by 김성남 on 2020/01/19.
//  Copyright © 2020 김성남. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController {

  var provider: CXProvider?
  var providerUpdate: CXCallUpdate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
    self.provider?.setDelegate(self, queue: DispatchQueue.main)
    
    self.providerUpdate = CXCallUpdate()
    self.providerUpdate?.remoteHandle = CXHandle(type: .generic, value: "Sn")
    self.provider?.reportNewIncomingCall(with: UUID(), update: self.providerUpdate!, completion: { (error) in
      print("error")
    })
  }


  @IBAction func endCallButtonTouched(_ sender: UIButton) {
    self.provider.end
  }
}

extension ViewController: CXProviderDelegate {
  func providerDidReset(_ provider: CXProvider) {
    
  }
  
  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
    action.fulfill(withDateConnected: Date())
  }
  
  func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
    action.fulfill()
  }
  
  
  
}

