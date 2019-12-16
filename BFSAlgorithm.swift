import Cocoa

func + (left: (Int, Int), right: (Int, Int)) -> (Int, Int)
{
    return (left.0 + right.0, left.1 + right.1)
}

func - (left: (Int, Int), right: (Int, Int)) -> (Int, Int)
{
    return (left.0 - right.0, left.1 - right.1)
}

func == (left: (Int, Int), right: (Int, Int)) -> Bool
{
    return left.0 == right.0 && left.1 == right.1
}

class BFSAlgorithm: NSObject
{
    let limit = 4
    var stepRecord = [[Int]]()

    let startXY = (0, 0), targetXY = (3, 3)
    var minStep = 9999

    let stepOptions = [(1, 2), (1, -2), (-1, 2), (-1, -2),
                    (2, 1), (2, -1), (2, 1), (-2, 1)]

    var nodeToMove = [(Int, Int)]()
    var stepCount = 0
    
    override init()
    {
        super.init()
        for _ in 0..<limit
        {
            let temp = [Int](repeating: -1, count: limit)
            stepRecord.append(temp)
        }
        stepRecord[startXY.0][startXY.0] = 0
        nodeToMove.append(startXY)
        move(startXY)
    }
    
    func move(_ previousXY: (Int,Int))
    {
        while nodeToMove.count > 0
        {
            let currentXY = nodeToMove.first!
            nodeToMove.removeFirst()
            if currentXY == targetXY
            {
                break
            }
            for step in stepOptions
            {
                let moveXY = currentXY + step
                if isValid(moveXY)
                {
                    stepRecord[moveXY.0][moveXY.1] = stepCount
                    nodeToMove.append(moveXY)
                }
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
