import Cocoa

class DFSAlgorithm: NSObject
{
    let limit = 4
    let initValue = 0
    var stepRecord = [[Int]]()
    let startPoint = DFSPoint()
    let targetPoint = DFSPoint(p: (3, 3))
    let stepKind = [(1, 2),
                    (1, -2),
                    (-1, 2),
                    (-1, -2),
                    (2, 1),
                    (2, -1),
                    (-2, 1),
                    (-2, -1)]

    override init()
    {
        super.init()
        for _ in 0..<limit
        {
            let temp = [Int](repeating: initValue, count: limit)
            stepRecord.append(temp)
        }
        dfs(previousPoint: startPoint)
    }

    func dfs(previousPoint: DFSPoint)
    {
        if previousPoint.point == targetPoint.point
        {
            for row in stepRecord
            {
                print(row)
            }
            print(previousPoint.stepCount)
            return
        }
        for item in stepKind
        {
            let movePoint = DFSPoint()
            movePoint.point = previousPoint.point + item
            movePoint.stepCount = previousPoint.stepCount + 1
            if isValid(movePoint.point)
            {
                stepRecord[movePoint.point.0][movePoint.point.1] = movePoint.stepCount
                dfs(previousPoint: movePoint)
                stepRecord[movePoint.point.0][movePoint.point.1] = initValue
            }
        }
    }
    
    
    func isValid(_ currentXY: (Int, Int)) -> Bool
    {
        return
            currentXY.0 >= 0 && currentXY.0 < limit &&
            currentXY.1 >= 0 && currentXY.1 < limit &&
            stepRecord[currentXY.0][currentXY.1] == initValue
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
