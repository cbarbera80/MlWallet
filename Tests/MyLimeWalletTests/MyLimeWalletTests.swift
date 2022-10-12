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
        
        let string = "Hello, World!"
        let signature = try! await sut.sign(userId: "cb2", password: "password", data: string)
        XCTAssertEqual(signature, "0x306c777e9f5b3bb96422260355f38838fd8e37b9444e289070bf58aeb9d665bc0de0516cd82b9a3b3151e9508abebf817ab894ae2c866cbbe9281abe1c3ef4161b")
        
    }
    
    @available(iOS 13.0.0, *)
    func test_right_publicKey() async {
    
        _ = try! await sut.generateKeyPair(userId: "cb2",
                                           password: "password",
                                           mnemonic: mnemonic)
        
        let string = "Hello, World!"
        let publicKey = try! await sut.getPublicKey(userId: "cb2", password: "password")
        XCTAssertEqual(publicKey, "0x044aeccd43d45b63b6f2921914fcc6661aa92738fadae59242a38dce733024310c8cc6db26ab037172fc41adfd7ef1ee95291b77c6e7e8e038a175a4723ee374d2")
        
    }
    
}
