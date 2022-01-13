import XCTest
@testable import MyLimeWallet

final class MyLimeWalletTests: XCTestCase {
   
    var sut: MlWallet!

    override func setUp() {
        sut = MlWallet()
        sut.fileManager.removeAllFiles()
    }
    
    override func tearDown() {
        sut.fileManager.removeAllFiles()
    }
    
    
    func test_signHelloWorld_withPassword() throws {
       
       _ = try! sut.generateKeyPair(userId: "cb2",
                                           password: "password",
                                           mnemonic: "divide they apology marble nice hurry long twenty dice banana else rabbit")
        
        let string = "Hello, World!"
        let signature = try! sut.sign(userId: "cb2", password: "password", data: string)
        let publicKey = try! sut.getPublicKey(userId: "cb2", password: "password")
        
        XCTAssertEqual(publicKey.toHexString(), "043d2ea0764201862c22cd2d77923876e1e66df90af96cbe9f4c7bcbf64d552585f2419864f672605dbbf3edaa80e4a78f0d0ec0d67a5ebbf8904ea1b7a97aab12")
        XCTAssertEqual(signature.flatten.toHexString(), "b5ab50294da34ffb5f0ef0e3de3b1e9b2b916c8f79d6e5d72da465317fc694b30ad0c04bad2447724aa8941b4d0f38dbd353ef137cc819e266da20fc4022e1d21c")
    }
    
    
    func test_myLime_with123456789() throws {
       
       _ = try! sut.generateKeyPair(userId: "cb1",
                                           password: "123456789",
                                           mnemonic: "divide they apology marble nice hurry long twenty dice banana else rabbit")
        
        let string = "my lime"
        let signature = try! sut.sign(userId: "cb1", password: "123456789", data: string)
        let publicKey = try! sut.getPublicKey(userId: "cb1", password: "123456789")
        
        XCTAssertEqual(publicKey.toHexString(), "044285ad9cd5ef100e72645c1579fa7a107a18336cda5525e3dda83af3367354cc950df1940fa9bee6aa45a94525b5c2a7de41bb4a8afa1f507d3ccdf0e7ab290c")
        
        XCTAssertEqual(signature.flatten.toHexString(), "f4da369adccf720bf81e31ad9bdbf9b8166eb3beef8716ad272a74abaffc6caf54e365ba8e8c1610b02ddbe99e30871f286fc1f6fe1bb4ce7203a6e0fc744dd31b")
    }
    
    func test_loremIpsum_withSamplePassword() throws {
       
       _ = try! sut.generateKeyPair(userId: "cb",
                                           password: "samplepassword",
                                           mnemonic: "divide they apology marble nice hurry long twenty dice banana else rabbit")
        
        let string = "Lorem Ipsum"
        let signature = try! sut.sign(userId: "cb", password: "samplepassword", data: string)
        let publicKey = try! sut.getPublicKey(userId: "cb", password: "samplepassword")
        
        XCTAssertEqual(publicKey.toHexString(), "044dfd5ab99e96ea18fd1733126866857435bd74a475f99fc93c0fa6d7f15dddf3ad3bc2b9eaf1ad9dcf89581dfbfbca780a0d17fd244405dbec4d0677a2a03cd1")
        
        XCTAssertEqual(signature.flatten.toHexString(), "ebb6eb73fb940c8716bd10fb9c0de67d68f84925b903eb51912380bba81e7e4810f96352ae5c497337c12d98543af6f6606a6a87c82cca4811eae3c51b7823261c")
    }
}

/*
 "Hello, World!", "password", "b5ab50294da34ffb5f0ef0e3de3b1e9b2b916c8f79d6e5d72da465317fc694b30ad0c04bad2447724aa8941b4d0f38dbd353ef137cc819e266da20fc4022e1d21c", "043d2ea0764201862c22cd2d77923876e1e66df90af96cbe9f4c7bcbf64d552585f2419864f672605dbbf3edaa80e4a78f0d0ec0d67a5ebbf8904ea1b7a97aab12"
 
 "my lime", "123456789", "f4da369adccf720bf81e31ad9bdbf9b8166eb3beef8716ad272a74abaffc6caf54e365ba8e8c1610b02ddbe99e30871f286fc1f6fe1bb4ce7203a6e0fc744dd31b", "044285ad9cd5ef100e72645c1579fa7a107a18336cda5525e3dda83af3367354cc950df1940fa9bee6aa45a94525b5c2a7de41bb4a8afa1f507d3ccdf0e7ab290c"
 
 "Lorem Ipsum", "samplepassword", "ebb6eb73fb940c8716bd10fb9c0de67d68f84925b903eb51912380bba81e7e4810f96352ae5c497337c12d98543af6f6606a6a87c82cca4811eae3c51b7823261c", "044dfd5ab99e96ea18fd1733126866857435bd74a475f99fc93c0fa6d7f15dddf3ad3bc2b9eaf1ad9dcf89581dfbfbca780a0d17fd244405dbec4d0677a2a03cd1"
 */
