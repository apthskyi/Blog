import Cocoa

public class ijCombine: NSObject//, Hashable
{
    public static func == (lhs: ijCombine, rhs: ijCombine) -> Bool
    {
        return lhs.ii == rhs.ii && lhs.jj == rhs.jj
    }
    
    init(i: Int, j: Int) {
        ii = i
        jj = j
    }
    var ii: Int
    var jj: Int
    
    public override var description: String
    {

        return "i: \(ii), j: \(jj)"
    }
}
