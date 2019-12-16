import Cocoa

class DFSAlgorithm: NSObject
{
    let limit = 4
    var stepRecord = [[Int]]()
    let startPoint = DFSPoint()
    let targetPoint = DFSPoint(p: (3, 3))
    let stepKind = [(1, 2), (1, -2), (-1, 2), (-1, -2),
                    (2, 1), (2, -1), (2, 1), (-2, 1)]

    override init()
    {
        super.init()
        for _ in 0..<limit
        {
            let temp = [Int](repeating: -1, count: limit)
            stepRecord.append(temp)
        }
        dfs(previousPoint: startPoint)
    }

    func dfs(previousPoint: DFSPoint)
    {
        if previousPoint.point == targetPoint.point
        {
            print(previousPoint.stepCount)
            return
        }
        for item in stepKind
        {
            let movePoint = DFSPoint()
            movePoint.point = previousPoint.point + item
            if isValid(movePoint.point)
            {
                print("x:\(movePoint.point.0), y:\(movePoint.point.1)")
                stepRecord[movePoint.point.0][movePoint.point.1] = 0
                dfs(previousPoint: movePoint)
                stepRecord[movePoint.point.0][movePoint.point.1] = -1
                print("x:\(previousPoint.point.0), y:\(previousPoint.point.1)")
            }
        }
    }
    
    
    func isValid(_ currentXY: (Int, Int)) -> Bool
    {
        return
            currentXY.0 >= 0 && currentXY.0 < limit &&
            currentXY.1 >= 0 && currentXY.1 < limit &&
            stepRecord[currentXY.0][currentXY.1] == -1
    }
}

class DFSPoint
{
    var point: (Int, Int) = (0, 0)
    var stepCount = 0
    
    init(){}
    
    init(p: (Int, Int))
    {
        point = p
    }
}
