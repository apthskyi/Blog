import Cocoa

class Hanoi
{
    func runTest()
    {
        hanoi(n: 2, A: "A", B: "B", C: "C")
    }
    
    func printResult(n: Int, from: String, to: String)
    {
        print("move \(n) from: \(from) to: \(to)")
    }
    
    func hanoi(n: Int, A: String, B: String, C: String)
    {
        if n == 1
        {
            printResult(n: 1, from: A, to: C)
        }
        else
        {
            hanoi(n: n - 1, A: A, B: C, C: B)
            printResult(n: n, from: A, to: C)
            hanoi(n: n - 1, A: B, B: A, C: C)
        }
    }
}
