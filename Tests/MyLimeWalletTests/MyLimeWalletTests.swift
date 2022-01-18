import XCTest
@testable import MyLimeWallet

final class MyLimeWalletTests: XCTestCase {
    
    var sut: MlWallet!
    let mnemonic = Mnemonic(phrase: "divide they apology marble nice hurry long twenty dice banana else rabbit")
    let wrongMnemonic = Mnemonic(phrase: "divide they apology marble nice hurry long twenty dice banana else rabbito")
    
    override func setUp() {
        sut = MlWallet()
        sut.fileManager.removeAllFiles()
    }
    
    override func tearDown() {
        sut.fileManager.removeAllFiles()
    }
    /*
    
    func test_cannot_import_wallet_with_wrong_mnemonics() {
        
        let pair = try? sut.generateKeyPair(userId: "cb2",
                                     password: "password",
                                     mnemonic: wrongMnemonic)
        
        XCTAssertNil(pair)
    }
    
    func test_import_wallet_with_right_mnemonics() {
        
        let pair = try? sut.generateKeyPair(userId: "cb2",
                                     password: "password",
                                     mnemonic: mnemonic)
        
        XCTAssertNotNil(pair)
    }
     */
    func test_signHelloWorld_withPassword() throws {
        
        _ = try! sut.generateKeyPair(userId: "cb2",
                                     password: "password",
                                     mnemonic: mnemonic)
        
        let string = "Hello, World!"
        let signature = try! sut.sign(userId: "cb2", password: "password", data: string)
        
        XCTAssertEqual(signature.flatten.toHexString(), "e29399b5485942731ca7dc3d8ca5aa2c3405bd4332c35e896e2b6f22102967e32f68f0f6e34b99676ee2e06c7c46148aaa07a0f161f943e9360684e48f4836901b")
    }
     
    /*
    func test_myLime_with123456789() throws {
        
        _ = try! sut.generateKeyPair(userId: "cb1",
                                     password: "123456789",
                                     mnemonic: mnemonic)
        
        let string = "my lime"
        let signature = try! sut.sign(userId: "cb1", password: "123456789", data: string)
       
        XCTAssertEqual(signature.flatten.toHexString(), "9044c8835649396392356d4474b9796c116e3459e5aab4b0778de9495b1c6c490e600fb393e3977631afa533cc94316cdcb0bdd1cc11a0ee5f1078f73dc47aef1b")
    }
    
    func test_loremIpsum_withSamplePassword() throws {
        
        _ = try! sut.generateKeyPair(userId: "cb",
                                     password: "samplepassword",
                                     mnemonic: mnemonic)
        
        let string = "Lorem Ipsum"
        let signature = try! sut.sign(userId: "cb", password: "samplepassword", data: string)
        
        XCTAssertEqual(signature.flatten.toHexString(), "c0af25b22f73dfb7377998ba34b1a9215ab761f2ba45316ee42629a1c92f5fdf17ec266667c9895da2414912fb185386ba62db99a383c9e8dc2a91768b1d38681c")
    }
    
    func test_randomString_withRandomPassword() throws {
        
        _ = try! sut.generateKeyPair(userId: "cb4",
                                     password: "randompassword",
                                     mnemonic: mnemonic)
        
        let string = "Random string 0123456789"
        let signature = try! sut.sign(userId: "cb4", password: "randompassword", data: string)
          
        XCTAssertEqual(signature.flatten.toHexString(), "6d573682bb6279063991aa1a6b42de314a8db560e6807a307855633b1be702a533028cfca697ac05b4e672524f0f145788402768bfd0f55ec866b96628aa13131c")
    } */
}
