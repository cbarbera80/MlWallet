# MlWallet

<a name="installation"/>

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate MyLimeSignManager into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'MyLimeWallet', :git => "https://gitlab.com/mylime/mylime-wallet.git"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler. 

Once you have your Swift package set up, adding MyLimeWallet as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://gitlab.com/mylime/mylime-wallet.git", from: "2.0.0")
]
```

## Content

MyLime Wallet main class. It manages user keys and allows signing.

``` swift
public class MlWallet 
```

## Initializers

### `init()`

``` swift
public init() 
```

## Methods

### `generateKeyPair(userId:password:mnemonic:)`

Generate a key pair for the given user
If a mnemonic is provided to this method, then the seed will be generated using it.
If the mnemonic is not provided, then a new random mnemonic will be used.

``` swift
public func generateKeyPair(userId: String, password: String, mnemonic: Mnemonic? = generateMnemonic()) throws -> (String, Mnemonic) 
```

#### Parameters

  - userId: the user ID
  - password: the password used to generate the seed
  - mnemonic: a mnemonic phrase to recover the keypair

#### Returns

the generated public key and the mnemonic phrase

### `hasKeys(for:)`

Checks if the given user has a stored keypair.

``` swift
public func hasKeys(for userId: String) -> Bool 
```

#### Parameters

  - userId: the user ID

#### Returns

true if there is a keypair associated to the user ID, false otherwise

### `deleteKeys(for:)`

Deletes the user's keypair.

``` swift
public func deleteKeys(for userId: String) 
```

#### Parameters

  - userId: the user ID

### `clearKeys()`

Deletes every stored keypair.

``` swift
public func clearKeys() 
```

### `isValidKeyPassword(userId:password:)`

Checks if the password is correct to use the given user keypair.

``` swift
public func isValidKeyPassword(userId: String, password: String) throws -> Bool 
```

#### Parameters

  - userId: the user ID
  - password: the password previously used to create the keypair

#### Returns

true if the password is correct, false otherwise

### `getPublicKey(userId:password:)`

Returns the user's public key.

``` swift
public func getPublicKey(userId: String, password: String) throws -> String 
```

#### Parameters

  - userId: the user ID
  - password: the password previously used to create the keypair

#### Returns

the user's public key

### `getBlockchainAddress(userId:password:)`

Returns the user's blockchain address.

``` swift
public func getBlockchainAddress(userId: String, password: String) throws -> String? 
```

#### Parameters

  - userId: the user ID
  - password: the password previously used to create the keypair

#### Returns

the blockchain address

### `sign(userId:password:data:)`

Signs data.

``` swift
public func sign(userId: String, password: String, data: String) throws -> String 
```

#### Parameters

  - userId: the user ID
  - password: the password previously used to create the keypair
  - data: the data to sign

#### Returns

an elliptic curve signature

### `generateMnemonic()`

``` swift
static public func generateMnemonic() -> Mnemonic? 
```

## Usage

### Create a key pair from scratch

1. Call `generateKeyPair(userId:password:mnemonic:)`, where USER_ID is the user ID and PASSWORD 
is the user chosen wallet password.
2. Show to the user the mnemonic result.
3. Send the public key to the MyLime platform.

Warning: the user must save and remember both the password and the mnemonic phrase. The password is
required for all the blockchain operation, the mnemonic to recreate the keypair if lost.
Note: the password is used only to secure the saved wallet, it’s not used to generate the key pair. The 
mnemonic phrase is enough to recover the key pair.

### Recreate a key pair if lost

1. Call `generateKeyPair(userId:password:mnemonic:)`, where USER_ID is the user ID, 
PASSWORD is the user wallet password (not necessarily the same as before) and MNEMONIC is 
the phrase returned by this method when the key pair was created from scratch.
2. Check if the generated public key is the same as the one already saved on MyLime for that user.

### Sign data

1. Call `sign(userId:password:data:)`
2. The signature result contains:
- r: Data, s: Data, v: Data. This triple is the signature.
- flatten: Data. This is the concatenation of r, s and v. You should use this value as 
signature. 

### Example:

- r: f73b4c6dcbb67ea7b8e7dce32558724dd0cd34fa0294e4f6f299b875b07a1ca5
- s: 79371add05377bcde74caf70c220db95004d98c0265b4de3a6fb7eb8262e2068
- v: 1c
- flatten: 
0xf73b4c6dcbb67ea7b8e7dce32558724dd0cd34fa0294e4f6f299b875b07a1ca579371add05377bcde74caf70c2
20db95004d98c0265b4de3a6fb7eb8262e20681c

Please refer to the MyLime platform documentation to know how to use this signature.
