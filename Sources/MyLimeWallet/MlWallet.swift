//
//  MlWallet.swift
//  
//
//  Created by Claudio Barbera on 11/01/22.
//

import Foundation
import web3swift
import CryptoSwift

/// MyLime Wallet main class. It manages user keys and allows signing.
public class MlWallet {
    
    let fileManager: FilesManager
    let walletUtils: WalletUtility
    let userDefaults = UserDefaults.init(suiteName: "mlwallet")!
    
    public init() {
        fileManager = FilesManager()
        walletUtils = WalletUtility(fileManager: fileManager)
    }
    
    /// Generate a key pair for the given user
    ///  If a mnemonic is provided to this method, then the seed will be generated using it.
    ///  If the mnemonic is not provided, then a new random mnemonic will be used.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password used to generate the seed
    ///   - mnemonic: a mnemonic phrase to recover the keypair
    /// - Returns: the generated public key and the mnemonic phrase
    public func generateKeyPair(userId: String, password: String, mnemonic: Mnemonic? = generateMnemonic()) throws -> (Data, Mnemonic) {
        
        guard let mnemonic = mnemonic  else {
            throw MlWalletException.missingMnemonics
        }
        
        guard mnemonic.isValid else {
            throw MlWalletException.wrongMnemonics
        }
        
        guard let keystore = try BIP32Keystore(mnemonics: mnemonic.phrase, password: password),
                let keystoreParams = keystore.keystoreParams
        else {
            throw MlWalletException.invalidKeystore
        }
        
        let manager = KeystoreManager(([keystore]))
        
        guard let address = keystore.addresses?.first else {
            throw MlWalletException.invalidAddress
        }
        
        let walletFileName = try walletUtils.save(params: keystoreParams)
        userDefaults.setValue(walletFileName, forKey: userId)
        
        let privateKey = try manager.UNSAFE_getPrivateKeyData(password: password, account: address)
        
        guard let publicKey = Web3.Utils.privateToPublic(privateKey, compressed: false) else {
            throw MlWalletException.invalidPublicKey
        }
        
        return (publicKey, mnemonic)
    }
    
    /// Generate a key pair for the given user
    ///  If a mnemonic is provided to this method, then the seed will be generated using it.
    ///  If the mnemonic is not provided, then a new random mnemonic will be used.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password used to generate the seed
    ///   - mnemonic: a mnemonic phrase to recover the keypair
    /// - Returns: the generated public key and the mnemonic phrase
    @available(iOS 13.0.0, *)
    public func generateKeyPair(userId: String, password: String, mnemonic: Mnemonic? = generateMnemonic()) async throws -> (Data, Mnemonic) {
        
        return try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                
                do {
                    let pair = try self.generateKeyPair(userId: userId, password: password, mnemonic: mnemonic)
                    continuation.resume(returning: pair)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Checks if the given user has a stored keypair.
    /// - Parameter userId: the user ID
    /// - Returns: true if there is a keypair associated to the user ID, false otherwise
    public func hasKeys(for userId: String) -> Bool {
        guard let filename = userDefaults.string(forKey: userId) else { return false }
        return fileManager.isFileExists(filename)
    }
    
    /// Deletes the user's keypair.
    /// - Parameter userId:  the user ID
    public func deleteKeys(for userId: String) {
        guard let filename = userDefaults.string(forKey: userId) else { return }
        fileManager.removeFile(filename)
        userDefaults.removeObject(forKey: userId)
    }
    
    /// Deletes every stored keypair.
    public func clearKeys() {
        let allDefaultKeys = userDefaults.dictionaryRepresentation().keys
        
        allDefaultKeys.forEach { [weak self] key in
            self?.fileManager.removeFile(key)
            userDefaults.removeObject(forKey: key)
        }
    }
    
    /// Checks if the password is correct to use the given user keypair.
    /// - Parameters:
    ///   - userId:  the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: true if the password is correct, false otherwise
    public func isValidKeyPassword(userId: String, password: String) throws -> Bool {
        if !hasKeys(for: userId) {
            throw MlWalletException.missingKeys
        }
        
        do {
            _ = try getCredentials(userId: userId, password: password)
            return true
        } catch {
            return false
        }
    }
    
    /// Checks if the password is correct to use the given user keypair.
    /// - Parameters:
    ///   - userId:  the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: true if the password is correct, false otherwise
    @available(iOS 13.0.0, *)
    public func isValidKeyPassword(userId: String, password: String) async throws -> Bool {
        
        return try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                
                do {
                    let res = try self.isValidKeyPassword(userId: userId, password: password)
                    continuation.resume(returning: res)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Returns the user's public key.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: the user's public key
    public func getPublicKey(userId: String, password: String) throws -> Data {
        if !hasKeys(for: userId) {
            throw MlWalletException.missingKeys
        }
    
        let credentials = try getCredentials(userId: userId, password: password)
        
        guard let address = credentials.address else { throw MlWalletException.invalidEthereumAddress }
        
        let privateKey = try credentials.manager.UNSAFE_getPrivateKeyData(password: password, account: address)
        
        guard let publicKey = Web3.Utils.privateToPublic(privateKey, compressed: false) else {
            throw MlWalletException.invalidPublicKey
        }
        
        return publicKey
    }
    
    /// Returns the user's public key.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: the user's public key
    @available(iOS 13.0, *)
    public func getPublicKey(userId: String, password: String) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                
                do {
                    let res = try self.getPublicKey(userId: userId, password: password)
                    continuation.resume(returning: res)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Returns the user's blockchain address.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: the blockchain address
    public func getBlockchainAddress(userId: String, password: String) throws -> String? {
        if !hasKeys(for: userId) {
            throw MlWalletException.missingKeys
        }
    
        let credentials = try getCredentials(userId: userId, password: password)
        return credentials.address?.address
    }
    
    /// Returns the user's blockchain address.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: the blockchain address
    @available(iOS 13.0.0, *)
    public func getBlockchainAddress(userId: String, password: String) async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                
                do {
                    let res = try self.getBlockchainAddress(userId: userId, password: password)
                    continuation.resume(returning: res)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    /// Signs data.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    ///   - data: the data to sign
    /// - Returns: an elliptic curve signature
    public func sign(userId: String, password: String, data: String) throws -> MlEcSignature {
        if !hasKeys(for: userId) {
            throw MlWalletException.missingKeys
        }
        
        let credentials = try getCredentials(userId: userId, password: password)
        guard let address = credentials.address else { throw MlWalletException.invalidEthereumAddress }
        
        let optionalSignature =  data
            .data(using: .utf8)
            .flatMap { try? Web3Signer.signPersonalMessage($0, keystore: credentials.keystore, account: address, password: password)}
            .flatMap(SECP256K1.unmarshalSignature)
        
        guard let signature = optionalSignature else {
            throw MlWalletException.signError
        }
        
        let s = MlEcSignature(r: signature.r, s: signature.s, v: Data([signature.v]))
        
        return s
    }
    
    /// Signs data.
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    ///   - data: the data to sign
    /// - Returns: an elliptic curve signature
    @available(iOS 13.0.0, *)
    public func sign(userId: String, password: String, data: String) async throws -> MlEcSignature {
        return try await withCheckedThrowingContinuation { continuation in
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                
                do {
                    let res = try self.sign(userId: userId, password: password, data: data)
                    continuation.resume(returning: res)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    static public func generateMnemonic() -> Mnemonic? {
        guard let mnemonicString = try? BIP39.generateMnemonics(bitsOfEntropy: 128) else { return nil }
        return Mnemonic(phrase: mnemonicString)
    }
}

extension MlWallet {
    /// Get the user keystore
    /// - Parameters:
    ///   - userId: the user ID
    ///   - password: the password previously used to create the keypair
    /// - Returns: a optional keystore
    func getCredentials(userId: String, password: String) throws -> Credential {
        guard let filename = userDefaults.string(forKey: userId),
              let data = walletUtils.loadData(from: filename),
              let keystore = BIP32Keystore(data),
              let address = keystore.addresses?.first
        else { throw MlWalletException.invalidStore }
        
        let keystoreManager =  KeystoreManager([keystore])
        
        _ = try keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: address)
        return Credential(keystore: keystore, manager: keystoreManager)
    }
    
}
