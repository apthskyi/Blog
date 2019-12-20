import Cocoa

protocol MyProtocol { func protocolMethod() }
extension MyProtocol
{
    func protocolMethod()
    {
        print("protocol")
    }
    
    func extensionMethod()
    {
        print("protocol")
    }
}


struct MyStruct: MyProtocol {}
extension MyStruct
{
    func protocolMethod()
    {
        print("struct")
    }
    
    func extensionMethod()
    {
        print("struct")
    }
}

class TestMethodCalling
{
    func test()
    {
        let myStruct = MyStruct()
        let proto: MyProtocol = myStruct
        myStruct.extensionMethod()
        myStruct.protocolMethod()

        proto.extensionMethod()
        proto.protocolMethod()
    }
}

