import Cocoa

class TestInit
{
    let numA: Int
    init(num: Int)
    {
        numA = num
    }
    
    required init()
    {
        numA = 0
    }
    
    convenience init( isCon: inout Bool)
    {
        self.init()
    }
    
}


class ChildTestInit: TestInit
{
    let numB: Int
    override init(num: Int) {
        numB = 100
        super.init(num: num)
    }
    
    required init()
    {
        numB = 101
        super.init()
        
        let arr = Array("abc")
        
        for ch in arr
        {
            print(ch)
        }
    }
    
    convenience init(test: Bool)
    {
        self.init()
    }
}
