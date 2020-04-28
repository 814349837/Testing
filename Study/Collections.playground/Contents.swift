import Cocoa


// 自定义 ary 高阶函数
var ary = [0, 1, 1, 2, 3, 4, 5]


print(ary.filter { $0 % 2 == 0 })

extension Array {
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
}
print(ary.myFilter { $0 % 2 == 0 })


print(ary.reduce(10, +))

extension Array {
    func myReduce<T>(_ initial: T, _ next: (T, Element) -> T) -> T {
        var tmp = initial
        for value in self {
            tmp = next(tmp, value)
        }
        return tmp
    }
}
print(ary.myReduce(0, +))



let animals = ["🐑", "🐂", "🐯", "🐶"]
let ids = ["绵羊", "牛", "老虎", "狗"]

print(

    animals.flatMap { animal in
        return ids.map { id in
                return (animal, id)
        }
    }

)

extension Array {
    func myFlatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var tmp: [T] = []
        for value in self {
            tmp.append(contentsOf: transform(value))
        }
        return tmp
    }
}
print(
    animals.myFlatMap { animal in ids.map { id in (animal, id) }}
)


// Dictionary

enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}

var record: [String: RecordType] = [
    "uid": .number(1),
    "exp": .number(100),
    "favo": .bool(false),
    "title": .text("Swift")
]


switch record["uid"] {
case .number(let value)?:
    print(value)
default:
    print("No ")
}

type(of: record["uid"])
record.count
record.isEmpty
record.keys.forEach { print($0) }
record.values.forEach { print($0) }

record.updateValue(.text("NEW"), forKey: "title")
print(record["title"])


for (k,v) in record {
    print("\(k):\(v)")
}

print("-------------------------")
let newRecord: [String: RecordType] = [
    "uid": .number(1),
    "exp": .number(200),
    "favo": .bool(true),
    "subtitle": .text("Yep")
]
record.merge(newRecord) { (type1:RecordType, type2:RecordType) -> RecordType in
    return type2
}
print(record)

//record.map(<#T##transform: ((key: String, value: RecordType)) throws -> T##((key: String, value: RecordType)) throws -> T#>)
//record.mapValues(<#T##transform: (RecordType) throws -> T##(RecordType) throws -> T#>)


// 为自定义结构实现Hashable
struct Account {
    var type: Int
    var alias: String
    var createdAt: Date
    
//    let INT_BIT = (Int)(CHAR_BIT)
    
}

extension Account: Hashable, Equatable {
    var hashValue: Int {
        return type.hashValue ^ alias.hashValue ^ createdAt.hashValue
    }
    // ==
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.type == rhs.type && lhs.alias == rhs.alias && lhs.createdAt == rhs.createdAt
    }
}

var data: [Account: Int]?


print("---------------------------")
// Set
var set: Set<Character> = ["a", "b", "c", "d", "e"]

var setA: Set = [1, 2, 3, 4, 5, 6]
var setB: Set = [4, 5, 6, 7, 8, 9]

let interSet = setA.intersection(setB)
let unionAB = setA.union(setB)
let symmetric = setA.symmetricDifference(setB)
let aSubtractB = setA.subtracting(setB)

//setA.formUnion(<#T##other: Sequence##Sequence#>)

1..<5
1...5

//Range
stride(from: 1.0, to: 5.0, by: 1.0)
