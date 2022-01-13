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
                                     mnemonic: .init(phrase: "divide they apology marble nice hurry long twenty dice banana else rabbit"))
        
        let string = "Hello, World!"
        let signature = try! sut.sign(userId: "cb2", password: "password", data: string)
        let publicKey = try! sut.getPublicKey(userId: "cb2", password: "password")
        
        XCTAssertEqual(publicKey.toHexString(), "0372be78a50f03e41f4823c94b7052a78cb27b05cfaef0dc33f76507b4baf40d2a")
        XCTAssertEqual(signature.flatten.toHexString(), "b01e2f589cd22c66742f57abdeb8cf0f5a68be7739def09141758cc596fc68352a7a7e3659c0844d3fae3cb5c88d323080f49eab4793e194b480e30684de26cb1b")
    }
    /*
     func test_myLime_with123456789() throws {
     
     _ = try! sut.generateKeyPair(userId: "cb1",
     password: "123456789",
     mnemonic: "divide they apology marble nice hurry long twenty dice banana else rabbit")
     
     let string = "my lime"
     let signature = try! sut.sign(userId: "cb1", password: "123456789", data: string)
     let publicKey = try! sut.getPublicKey(userId: "cb1", password: "123456789")
     
     XCTAssertEqual(publicKey.toHexString(), "024285ad9cd5ef100e72645c1579fa7a107a18336cda5525e3dda83af3367354cc")
     
     XCTAssertEqual(signature.flatten.toHexString(), "f4da369adccf720bf81e31ad9bdbf9b8166eb3beef8716ad272a74abaffc6caf54e365ba8e8c1610b02ddbe99e30871f286fc1f6fe1bb4ce7203a6e0fc744dd31b")
     }
     
     func test_loremIpsum_withSamplePassword() throws {
     
     _ = try! sut.generateKeyPair(userId: "cb",
     password: "samplepassword",
     mnemonic: "divide they apology marble nice hurry long twenty dice banana else rabbit")
     
     let string = "Lorem Ipsum"
     let signature = try! sut.sign(userId: "cb", password: "samplepassword", data: string)
     let publicKey = try! sut.getPublicKey(userId: "cb", password: "samplepassword")
     
     XCTAssertEqual(publicKey.toHexString(), "034dfd5ab99e96ea18fd1733126866857435bd74a475f99fc93c0fa6d7f15dddf3")
     
     XCTAssertEqual(signature.flatten.toHexString(), "ebb6eb73fb940c8716bd10fb9c0de67d68f84925b903eb51912380bba81e7e4810f96352ae5c497337c12d98543af6f6606a6a87c82cca4811eae3c51b7823261c")
     }
     
     func test_randomString_withRandomPassword() throws {
     
     _ = try! sut.generateKeyPair(userId: "cb4",
     password: "randompassword",
     mnemonic: "divide they apology marble nice hurry long twenty dice banana else rabbit")
     
     let string = "Random string 0123456789"
     let signature = try! sut.sign(userId: "cb4", password: "randompassword", data: string)
     let publicKey = try! sut.getPublicKey(userId: "cb4", password: "randompassword")
     
     XCTAssertEqual(publicKey.toHexString(), "03322489fea26d0139447235d25f679ee8cd7669dc21164ad6015556193b6c9184")
     
     XCTAssertEqual(signature.flatten.toHexString(), "94a77b3820f08927b5627bd351c11405ccd5f563282e64ee268edc65ed1303eb70ca1cd67fe64aa91a2767ae655a2e6b6edfb2e47bb6378cef20087cc723253c1c")
     } */
}

/*
 "Hello, World!", "password", "b5ab50294da34ffb5f0ef0e3de3b1e9b2b916c8f79d6e5d72da465317fc694b30ad0c04bad2447724aa8941b4d0f38dbd353ef137cc819e266da20fc4022e1d21c", "023d2ea0764201862c22cd2d77923876e1e66df90af96cbe9f4c7bcbf64d552585"
 
 "my lime", "123456789", "f4da369adccf720bf81e31ad9bdbf9b8166eb3beef8716ad272a74abaffc6caf54e365ba8e8c1610b02ddbe99e30871f286fc1f6fe1bb4ce7203a6e0fc744dd31b", "024285ad9cd5ef100e72645c1579fa7a107a18336cda5525e3dda83af3367354cc"
 
 "Lorem Ipsum", "samplepassword", "ebb6eb73fb940c8716bd10fb9c0de67d68f84925b903eb51912380bba81e7e4810f96352ae5c497337c12d98543af6f6606a6a87c82cca4811eae3c51b7823261c", "034dfd5ab99e96ea18fd1733126866857435bd74a475f99fc93c0fa6d7f15dddf3"
 
 "Random string 0123456789", "randompassword", "94a77b3820f08927b5627bd351c11405ccd5f563282e64ee268edc65ed1303eb70ca1cd67fe64aa91a2767ae655a2e6b6edfb2e47bb6378cef20087cc723253c1c", "03322489fea26d0139447235d25f679ee8cd7669dc21164ad6015556193b6c9184"
 */
