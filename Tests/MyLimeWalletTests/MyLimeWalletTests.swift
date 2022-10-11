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
    
    @available(iOS 13.0.0, *)
    func test_signHelloWorld_withPassword() throws {
        
        Task {
            _ = try! await sut.generateKeyPair(userId: "cb2",
                                         password: "password",
                                         mnemonic: mnemonic)
            
            let string = "Hello, World!"
            let signature = try! await sut.sign(userId: "cb2", password: "password", data: string)
            
            XCTAssertEqual(signature, "e29399b5485942731ca7dc3d8ca5aa2c3405bd4332c35e896e2b6f22102967e32f68f0f6e34b99676ee2e06c7c46148aaa07a0f161f943e9360684e48f4836901b")
        }
    }
}
