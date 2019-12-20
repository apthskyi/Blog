
import Cocoa

class TopoSort: NSObject
{
    func runTest()
    {
        let allGraphNote = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];

        let relationDirectedGraph: Array<(String, String, Int)> =
            [("A", "B", 10), ("A", "F", 11), ("B", "C", 18), ("B", "I", 12), ("B", "G", 16),
             ("F", "G", 17), ("F", "E", 26), ("C", "I", 8), ("C", "D", 22), ("I", "D", 21),
             ("G", "H", 19), ("G", "D", 24), ("H", "D", 16), ("E", "H", 7), ("E", "D", 20)];

        let graph = GraphAdjacencyList(notes: allGraphNote,
                                       relations: relationDirectedGraph,
                                       isNotDirection: false)
        graph.displayGraph()

        graph.topoLogicalSort()
    }
}

/// 链表上的节点
class GraphAdjacencyListNote
{
    var data: String
    var weightNumber: Int   //权值或者入度
    var inCount: Int = 0
    var next: GraphAdjacencyListNote?
    
    init(data: String = "", weightNumber: Int = 0) {
        self.data = data
        self.weightNumber = weightNumber
    }
}

class Stack {
    private var stack: Array<GraphAdjacencyListNote> = []
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
    
    func push(note: GraphAdjacencyListNote) {
        stack.append(note)
    }
    
    func pop() -> GraphAdjacencyListNote? {
        if !isEmpty() {
           return stack.removeLast()
        }
        return nil
    }
}

class Queue
{
    private var queue: Array<GraphAdjacencyListNote> = []
    
    func count() -> Int {
        return queue.count
    }
    
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
    
    func enQueue(note: GraphAdjacencyListNote) {
        queue.append(note)
    }
    
    func deQueue() -> GraphAdjacencyListNote? {
        if !isEmpty() {
            return queue.removeFirst()
        }
        return nil
    }
    
    func display() {
        for item in queue {
            print(item.data, separator: "", terminator: " ")
        }
        print()
    }
}



class GraphAdjacencyList
{
    fileprivate var relation: Array<(String, String, Int)>
    fileprivate var graph: [String: GraphAdjacencyListNote]
    fileprivate var topoLogicalNoteQueue: Queue = Queue()
    
    init() {
        graph = [:]
        relation = []
    }
    
    
    /// 有向图
    ///
    /// - parameter notes:          图的所有节点
    /// - parameter relations:      图中节点中的关系
    /// - parameter isNotDirection: 边是否有方向
    ///
    /// - returns:
    init(notes: Array<String>, relations: Array<(String, String, Int)>, isNotDirection: Bool) {
        graph = [:]
        relation = []
        createGraph(notes: notes, relation: relations)
    }

    
    // MARK: - GraphType
    func createGraph(notes: Array<String>, relation: Array<(String, String, Int)>)
    {
        self.relation = relation
        for i in 0..<notes.count
        {
            let note = GraphAdjacencyListNote(data: notes[i])
            graph[notes[i]] = note
        }
        
        for item in relation
        {
            guard let from = graph[item.0] else { continue }
            let to = GraphAdjacencyListNote(data: item.1)
            let temp = from.next
            to.next = temp
            from.next = to
            graph[item.1]!.inCount += 1  //将被挂上的节点的入度加1
        }
    }
    
    func topoLogicalSort()
    {
        let stack: Stack = Stack()
        //将入度为0的结点入栈
        for (key, value) in graph
        {
            if value.inCount == 0
            {
                stack.push(note: value)
            }
        }
        
        while !stack.isEmpty()
        {
            guard let note = stack.pop() else { return }
            topoLogicalNoteQueue.enQueue(note: note)
            
            var cursor = note.next
            while cursor != nil
            {
                let node = graph[cursor!.data]!
                node.inCount -= 1
                //减一后，如果入度为0，则进入栈
                if node.inCount == 0
                {
                    stack.push(note: node)
                }
                cursor = cursor!.next
            }
        }
        
        if topoLogicalNoteQueue.count() == graph.count {
            //输出topo排序的序列
            print("拓扑排序的序列为：")
            topoLogicalNoteQueue.display()
        } else {
            print("图中存在环路，不存在topo序列")
        }
    }
    
    func displayGraph()
    {
        print("有向图：AOV网")
        for i in graph
        {
            print("\(i.value.data)(\(i.value.inCount))", separator: "", terminator: "\t->  ")
            var cursor: GraphAdjacencyListNote? = i.value.next
            while cursor != nil
            {
                print("\(cursor!.data)(\(cursor!.inCount))", separator: "", terminator: "\t->  ")
                cursor = cursor?.next
            }
            print("nil")
        }
        print()
    }
}
