//
//  Wallet.swift
//  MJWallet
//
//  Created by APPLE DEVELOPER ACADEMY on 16/10/18.
//  Copyright © 2018 APPLE DEVELOPER ACADEMY. All rights reserved.
//
import struct BigInt.BigUInt
import web3swift
import Foundation

class Wallet{
    static let shared = Wallet()
    
    var keystore:EthereumKeystoreV3!
    
    var contract = "0xe5be69806d8008a9a1086930bc8ba04db8c6b541"
    
    var ABI = "[     {         \"anonymous\": false,         \"inputs\": [             {                 \"indexed\": true,                 \"name\": \"owner\",                 \"type\": \"address\"             },             {                 \"indexed\": true,                 \"name\": \"spender\",                 \"type\": \"address\"             },             {                 \"indexed\": false,                 \"name\": \"value\",                 \"type\": \"uint256\"             }         ],         \"name\": \"Approval\",         \"type\": \"event\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"spender\",                 \"type\": \"address\"             },             {                 \"name\": \"tokens\",                 \"type\": \"uint256\"             }         ],         \"name\": \"approve\",         \"outputs\": [             {                 \"name\": \"success\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"spender\",                 \"type\": \"address\"             },             {                 \"name\": \"tokens\",                 \"type\": \"uint256\"             },             {                 \"name\": \"data\",                 \"type\": \"bytes\"             }         ],         \"name\": \"approveAndCall\",         \"outputs\": [             {                 \"name\": \"success\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"spender\",                 \"type\": \"address\"             },             {                 \"name\": \"subtractedValue\",                 \"type\": \"uint256\"             }         ],         \"name\": \"decreaseAllowance\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"spender\",                 \"type\": \"address\"             },             {                 \"name\": \"addedValue\",                 \"type\": \"uint256\"             }         ],         \"name\": \"increaseAllowance\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [],         \"name\": \"renounceOwnership\",         \"outputs\": [],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"to\",                 \"type\": \"address\"             },             {                 \"name\": \"tokens\",                 \"type\": \"uint256\"             }         ],         \"name\": \"transfer\",         \"outputs\": [             {                 \"name\": \"success\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"from\",                 \"type\": \"address\"             },             {                 \"name\": \"to\",                 \"type\": \"address\"             },             {                 \"name\": \"tokens\",                 \"type\": \"uint256\"             }         ],         \"name\": \"transferFrom\",         \"outputs\": [             {                 \"name\": \"success\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"constant\": false,         \"inputs\": [             {                 \"name\": \"newOwner\",                 \"type\": \"address\"             }         ],         \"name\": \"transferOwnership\",         \"outputs\": [],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"function\"     },     {         \"anonymous\": false,         \"inputs\": [             {                 \"indexed\": true,                 \"name\": \"previousOwner\",                 \"type\": \"address\"             },             {                 \"indexed\": true,                 \"name\": \"newOwner\",                 \"type\": \"address\"             }         ],         \"name\": \"OwnershipTransferred\",         \"type\": \"event\"     },     {         \"anonymous\": false,         \"inputs\": [             {                 \"indexed\": true,                 \"name\": \"from\",                 \"type\": \"address\"             },             {                 \"indexed\": true,                 \"name\": \"to\",                 \"type\": \"address\"             },             {                 \"indexed\": false,                 \"name\": \"value\",                 \"type\": \"uint256\"             }         ],         \"name\": \"Transfer\",         \"type\": \"event\"     },     {         \"payable\": true,         \"stateMutability\": \"payable\",         \"type\": \"fallback\"     },     {         \"inputs\": [],         \"payable\": false,         \"stateMutability\": \"nonpayable\",         \"type\": \"constructor\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"_remainingTokens\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"uint256\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"_totalSupply\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"uint256\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [             {                 \"name\": \"tokenOwner\",                 \"type\": \"address\"             },             {                 \"name\": \"spender\",                 \"type\": \"address\"             }         ],         \"name\": \"allowance\",         \"outputs\": [             {                 \"name\": \"remaining\",                 \"type\": \"uint256\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [             {                 \"name\": \"tokenOwner\",                 \"type\": \"address\"             }         ],         \"name\": \"balanceOf\",         \"outputs\": [             {                 \"name\": \"balance\",                 \"type\": \"uint256\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"basePrice\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"uint256\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"decimals\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"uint8\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"isOwner\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"bool\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"name\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"string\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"owner\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"address\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"symbol\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"string\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     },     {         \"constant\": true,         \"inputs\": [],         \"name\": \"totalSupply\",         \"outputs\": [             {                 \"name\": \"\",                 \"type\": \"uint256\"             }         ],         \"payable\": false,         \"stateMutability\": \"view\",         \"type\": \"function\"     } ]"
    // Initialization
    private init() {
        
    }
    
    func keyStoreFileExists() -> Bool{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
       
       
        if FileManager.default.fileExists(atPath: userDir + "/keystore"+"/key.json") {
            return true
        } else {
            return false
        }
    }
    
    func getKeysToreManager() -> KeystoreManager{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return KeystoreManager.managerForPath(userDir + "/keystore")!
        
        
    }
       
    
    func retrieveWallet(password:String) -> EthereumKeystoreV3{
        if keystore != nil {
            return keystore;
        }
        let keystoreManager = getKeysToreManager()
        
        keystore = keystoreManager.walletForAddress(keystoreManager.addresses![0]) as? EthereumKeystoreV3
        
        
        
        
        return keystore
        
    }
    func createWallet(password:String) -> EthereumKeystoreV3{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
       
        do{
            keystore = try EthereumKeystoreV3(password: password)
            let keydata = try JSONEncoder().encode(keystore!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata, attributes: nil)
        }catch{
            print(error.localizedDescription)
        }
        
        return keystore
        
    }
    
    func createWalletFromPrivateKey(key:String,password:String) -> EthereumKeystoreV3{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        do{
            keystore = try EthereumKeystoreV3(privateKey: Data.fromHex(key)!, password: password)
            let keydata = try JSONEncoder().encode(keystore!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata, attributes: nil)
        }catch{
            print(error.localizedDescription)
        }
        
        
        return (keystore ?? nil)!
        
    }
    
    
    func getPrivateKey(password:String) ->String{
        do{
            let key = try keystore.UNSAFE_getPrivateKeyData(password: password, account: (keystore.addresses?.first)!).toHexString()
            return key
        }catch{
            print(error.localizedDescription)
            return ""
        }
        
        
        
        
    }
    
    func getBalance() -> BigUInt {
       
        return Wallet.getBalanceFromAdress(address: (keystore.addresses?.first)!)
        
    }
    
    static func getBalanceFromAdress(address:EthereumAddress) -> BigUInt {
        let web3Rinkeby = Web3.InfuraRinkebyWeb3()
        let balanceResult = web3Rinkeby.eth.getBalance(address: address)
        
        guard case .success(let balance) = balanceResult else {return 0}
        return balance
        
    }
    
    func getMJBalance() -> BigUInt {
        let web3Rinkeby = Web3.InfuraRinkebyWeb3()
        let constractAddress = EthereumAddress(contract)!
        let contractABI = web3Rinkeby.contract(ABI, at: constractAddress, abiVersion: 2)!
        
        let gasPriceResult = web3Rinkeby.eth.getGasPrice()
        guard case .success(let gasPrice) = gasPriceResult else {return 0}
        
        let from = (keystore.addresses?.first)!
        
        web3Rinkeby.addKeystoreManager(getKeysToreManager())

        
        var options = Web3Options.defaultOptions()
        options.gasPrice = gasPrice
        options.from = from
       
        
        guard let bkxBalanceResult = contractABI.method("balanceOf", parameters: [from] as [AnyObject], options: options)?.call(options: nil) else {return 0}
        guard case .success(let bkxBalance) = bkxBalanceResult, let bal = bkxBalance["0"] as? BigUInt else {return 0}
        print("BKX token balance = " + String(bal))
        
        return bal
        
    }
    
    func buyMJToken(eth:BigUInt,password:String) ->Bool{
        let web3Rinkeby = Web3.InfuraRinkebyWeb3()
        web3Rinkeby.addKeystoreManager(getKeysToreManager())
        let gasPriceResult = web3Rinkeby.eth.getGasPrice()
        guard case .success(let gasPrice) = gasPriceResult else {return false}
        var options = Web3Options.defaultOptions()
        options.gasPrice = gasPrice
        options.from = (keystore.addresses?.first)!
        
        let constractAddress = EthereumAddress(contract)!

        
        let intermediateSend = web3Rinkeby.eth.sendETH(to: constractAddress, amount: eth, extraData: Data(), options: options)
        
        //(from: , to: EthereumAddress("0x25846ff098351CDAA18472E46ac28C6850afB63e")!, amount: eth)
        //(to: , amount: eth)
        
        //sendETH(to: "0x25846ff098351CDAA18472E46ac28C6850afB63e", amount: eth)
        
        let sendResult = intermediateSend!.send(password: password)
        print(sendResult.debugDescription)
        guard case .success(let sendingResult) = sendResult else { return false}
        let txid = sendingResult.hash
        print("On Rinkeby TXid = " + txid)
        return true
    }
    
    
    
}
