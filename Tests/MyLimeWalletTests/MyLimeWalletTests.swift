import XCTest
@testable import MyLimeWallet

final class MyLimeWalletTests: XCTestCase {
    
    var sut: MlWallet!
    let mnemonic = Mnemonic(phrase: "flee area foster cheese flight dawn valley add season happy plug craft")
    let wrongMnemonic = Mnemonic(phrase: "divide they apology marble nice hurry long twenty dice banana else rabbito")
    
    override func setUp() {
        sut = MlWallet()
        sut.fileManager.removeAllFiles()
    }
    
    override func tearDown() {
        sut.fileManager.removeAllFiles()
    }
    
    @available(iOS 13.0.0, *)
    func test_signHelloWorld_withPassword() async {
    
        _ = try! await sut.generateKeyPair(userId: "cb2",
                                           password: "password",
                                           mnemonic: mnemonic)
        
        let string = "{\"id\":\"tag_07-10-2022-093819_0\",\"name\":\"tag_11-10-2022-080856_3\",\"user_id\":null,\"method\":\"update\",\"updateId\":1,\"Asset, Claim\":{\"Attribute Code\":\"Asset, Claim\",\"Attribute Label\":\"transfer of ownership of the asset to the consumer\"}}"
        let signature = try! await sut.sign(userId: "cb2", password: "password", data: string)
        print(signature)
        XCTAssertEqual(signature, "e29399b5485942731ca7dc3d8ca5aa2c3405bd4332c35e896e2b6f22102967e32f68f0f6e34b99676ee2e06c7c46148aaa07a0f161f943e9360684e48f4836901b")
        
    }
}
