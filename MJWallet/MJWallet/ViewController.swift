//
//  ViewController.swift
//  MJWallet
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/18.
//  Copyright © 2018 APPLE DEVELOPER ACADEMY. All rights reserved.
//

import UIKit
import struct BigInt.BigUInt
import web3swift
//private: 1f7e9967e953df3ae3a563cecb41b1380fe6b4653a9d6282b9a0c353622ec2aa
//public: 0xd2e04cb9ddaa3b3566721246e25349a6e5418223

//https://github.com/matterinc/web3swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        if(Wallet.shared.keyStoreFileExists()){
            let sender:EthereumKeystoreV3 = Wallet.shared.retrieveWallet(password: "AppleDeveloperAcademy")
            print(sender)
            
            print("Balance:"  + String(Wallet.shared.getBalance()))
            
            print("Private Key:"+Wallet.shared.getPrivateKey(password: "AppleDeveloperAcademy"))
            
            print("buy tokens")
            if Wallet.shared.buyMJToken(eth: 100000000000, password: "AppleDeveloperAcademy"){
                print("buy tokens")
                _ = Wallet.shared.getMJBalance()
            }else{
                print("error tokens")
                
            }
            
        }else{
            print("Wallet file does not exists")
        }
        
        
    }


    
    
    
    
    
}

