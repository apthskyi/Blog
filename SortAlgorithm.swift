import Cocoa

class SortAlgorithm
{
    var arr = [1, 17, 80, 68,
               5, 5, 58, 17,
               38, 81, 26, 44,
               38, 6, 12, 11,
               37, 67, 70, 16,
               19, 35, 71, 16,
               32, 45, 7, 39,
               2, 14, 16, 78,
               82, 5, 18, 86,
               61, 37, 12, 8,
               27, 90, 13, 26,
               57, 24, 36];
    
    //Quick Sort
    func quickSort(arr: inout [Int]) -> [Int]
    {
        if arr.count == 0 { return [] }
        let middle = arr.removeFirst()
        var filterLow = arr.filter { $0 < middle }
        var filterHigh = arr.filter { $0 >= middle }
        var low = quickSort(arr: &filterLow)
        let high = quickSort(arr: &filterHigh)
        low.append(middle)
        low.append(contentsOf: high)
        return low
    }
    
    //Merge Sort
    func mergeSort(arr: inout [Int]) -> [Int]
    {
        guard arr.count > 1 else { return arr }
        let middleIndex = arr.count / 2
        var unsortedLeft = Array(arr[0..<middleIndex])
        var unsortedRight = Array(arr[middleIndex..<arr.count])
        let leftArray = mergeSort(arr: &unsortedLeft)
        let rightArray = mergeSort(arr: &unsortedRight)
        return realMergeSort(firstList: leftArray, secondList: rightArray)
    }
    
    func realMergeSort(firstList:[Int], secondList: [Int]) -> [Int]
    {
        var result = [Int]()
        var firstIndex = 0
        var secondIndex = 0
        while firstIndex < firstList.count && secondIndex < secondList.count
        {
            if firstList[firstIndex] < secondList[secondIndex]
            {
                result.append(firstList[firstIndex])
                firstIndex += 1
            }
            else
            {
                result.append(secondList[secondIndex])
                secondIndex += 1
            }
        }
        if firstIndex < firstList.count
        {
            result.append(contentsOf: firstList[firstIndex..<firstList.count])
        }
        else if secondIndex < secondList.count
        {
            result.append(contentsOf: secondList[secondIndex..<secondList.count])
        }
        return result
    }
    
    
    //Cycle sort
    func cycleSort(array: inout [Int])
    {
        // step 1: loop from the beginning of the array to the second to last item
        for currentIndex in 0..<(array.count - 1)
        {
            // step 2: save the value of the item at the currentIndex
            var item = array[currentIndex]
            // step 3: save a copy of the current index
            var currentIndexCopy = currentIndex

            // step 4: loop through all indexes that proceed the currentIndex
            for i in (currentIndex + 1)..<array.count {
                if (array[i] < item) {
                    currentIndexCopy += 1
                }
            }

            // step 5: if currentIndexCopy has not changed, the item at the currentIndex is already in the correct position
            if (currentIndexCopy == currentIndex) {
                continue;
            }

            // step 6: skip duplicates
            while (item == array[currentIndexCopy]) {
                currentIndexCopy += 1
            }

            // step 7: swap
            var temp = array[currentIndexCopy]
            array[currentIndexCopy] = item
            item = temp

            // step 8: repeat steps 4, 6 and 7 above as long as we can find values to swap
            while (currentIndexCopy != currentIndex) {

                // step 9: save a copy of the currentIndex
                currentIndexCopy = currentIndex

                // step 10: repeat step 4
                for i in (currentIndex + 1)..<array.count {
                    if array[i] < item {
                        currentIndexCopy += 1
                    }
                }

                // step 10: repeat step 6
                while (item == array[currentIndexCopy]) {
                    currentIndexCopy += 1
                }

                // step 10: repeat step 7
                temp = array[currentIndexCopy]
                array[currentIndexCopy] = item
                item = temp
            }
        }
    }
    
    //Bucket Sort
    //O(n) time
    func BucketSort(min:Int,max:Int,gap:Int) {


        var bucketlist:[[Int]] = []
        let bucketCount:Int = (max - min) / gap + 1
        
        // 建桶
        for _ in 0..<bucketCount {
            let temp:[Int] = []
            bucketlist.append(temp)
        }
        
        // 分桶
        for i in 0..<arr.count {
            let index:Int = (arr[i] - min) / gap
            bucketlist[index].append(arr[i])
        }
        
        // 小桶排序
        for i in 0..<bucketCount {
            if bucketlist[i].count > 0 {
                buketInnerSort(arr: &bucketlist[i])
            }
        }
        
        var index:Int = 0
        for i in 0..<bucketCount {
            let bucket:[Int] = bucketlist[i]
            if bucket.count > 0 {
                for j in 0..<bucket.count {
                    arr[index] = bucket[j]
                    index += 1
                }
            }
        }
        
    }

    private func buketInnerSort(arr:inout [Int])  {
        let count:Int = arr.count
        for i in 1..<count {
            for j in (1...i).reversed() {
                if arr[j] < arr[j-1] {
                    arr.swapAt(j, j-1)
                }
            }
        }
    }
    
    
    //Radix Sort
    //O(d*2n) time，
    //O(n+k) space
    func radixSort()
    {
        if arr.count == 0 {
          return
        }

        var list:[[Int]] = []
        for _ in 0..<10
        {
          let temp:[Int] = []
          list.append(temp)
        }

        let maxDigit:Int = maxlength(arr: arr)
        var tempArr:[Int] = arr
        for i in 0..<maxDigit
        {
          for j in 0..<arr.count
          {
              let index:Int = highDigit(num: tempArr[j], index: i)
              list[index].append(tempArr[j])
          }
          saveBucketData(bucketlist: &list, arr: &tempArr)
        }
        arr = tempArr
    }

    // 桶的数据插入数组
    private func saveBucketData(bucketlist:inout [[Int]],arr:inout [Int])
    {
        var index:Int = 0
        for i in 0..<bucketlist.count
        {
          let bucket:[Int] = bucketlist[i]
          if bucket.count > 0
          {
              for j in 0..<bucket.count
              {
                  arr[index] = bucket[j]
                  index += 1
              }
          }
          bucketlist[i].removeAll() // 注意清空桶数据
        }
    }

    private func highDigit(num:Int,index:Int)->Int
    {
        let base:Double = pow(10, Double(index))
        let high:Int = (num / Int(base)) % 10
        return high
    }

    // 最大数字的位数
    private func maxlength(arr:[Int])->Int
    {
        var max:Int = 0
        for i in 0..<arr.count
        {
          let count:Int = positionOfNum(number: arr[i])
          if count > max
          {
              max = count
          }
        }
        return max
    }

    // 统计数字的位数
    private func positionOfNum(number:Int)->Int
    {
        var count:Int = 0
        var num:Int = number
        while num%10 > 0
        {
          count += 1
          num = num / 10
        }
        return count
    }
}
