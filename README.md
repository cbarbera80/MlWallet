# MlWallet

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
public func generateKeyPair(userId: String, password: String, mnemonic: Mnemonic? = generateMnemonic()) throws -> (Data, Mnemonic) 
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
public func getPublicKey(userId: String, password: String) throws -> Data 
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
public func sign(userId: String, password: String, data: String) throws -> MlEcSignature 
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
