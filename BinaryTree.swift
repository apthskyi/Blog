import Cocoa

class TreeNode
{
    init(_ value: Int) { val = value }
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
}

class BinaryTree
{
    
    //     0
    //    / \
    //   1   2
    //  / \ / \
    // 3  4 5  6
    var tree: TreeNode = {
        let treeRoot = TreeNode(0)
        
        treeRoot.left = TreeNode(1)
        treeRoot.right = TreeNode(2)
        
        treeRoot.left?.left = TreeNode(3)
        treeRoot.left?.right = TreeNode(4)
        
        treeRoot.right?.left = TreeNode(5)
        treeRoot.right?.right = TreeNode(6)
        return treeRoot
    }()

    func invertTreeTest()
    {
        invertTree(root: tree)
        invertTreeInWhile(root: tree)
    }
    
    func invertTree(root: TreeNode?) -> TreeNode?
    {
        if root == nil { return nil }
        root!.left = invertTree(root: root!.left)
        root!.right = invertTree(root: root!.right)
        (root!.left, root!.right) = (root!.right, root!.left)
        return root
    }
    
    func invertTreeInWhile(root: TreeNode?)
    {
        if root == nil { return }
        if (root?.left == nil && root?.right == nil) { return }
        var stack = [TreeNode]()
        stack.append(root!)
        while stack.count > 0
        {
            let node = stack.first
            stack.removeFirst()
            (node!.left, node!.right) = (node!.right, node!.left)
            if node?.left != nil
            {
                stack.append(node!.left!)
            }
            if node?.right != nil
            {
                stack.append(node!.right!)
            }
        }
    }
    
    func bfsTraverse()
    {
        var nodesToTraverse = [TreeNode]()
        nodesToTraverse.append(tree)
        while nodesToTraverse.count > 0
        {
            let node = nodesToTraverse.removeFirst()
            print(node.val)
            if let left = node.left
            {
                nodesToTraverse.append(left)
            }
            if let right = node.right
            {
                nodesToTraverse.append(right)
            }
        }
    }
    
    func traverse()
    {
        preOrderTraverse(rootNode: tree)
        inOrderTraverse(rootNode: tree)
        afterOrderTraverse(rootNode: tree)
    }
    
    func preOrderTraverse(rootNode: TreeNode)
    {
        print(rootNode.val)
        if let left = rootNode.left
        {
            preOrderTraverse(rootNode: left)
        }
        if let right = rootNode.right
        {
            preOrderTraverse(rootNode: right)
        }
    }
    
    func inOrderTraverse(rootNode: TreeNode)
    {
        if let left = rootNode.left
        {
            inOrderTraverse(rootNode: left)
        }
        print(rootNode.val)
        if let right = rootNode.right
        {
            inOrderTraverse(rootNode: right)
        }
    }
    
    func afterOrderTraverse(rootNode: TreeNode)
    {
        if let left = rootNode.left
        {
            afterOrderTraverse(rootNode: left)
        }
        if let right = rootNode.right
        {
            afterOrderTraverse(rootNode: right)
        }
        print(rootNode.val)
    }
}
