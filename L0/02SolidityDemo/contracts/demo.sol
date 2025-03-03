// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract HelloWorld {
    string public greet = "Hello World";
}
//计数器
contract Counter {
    uint256 public count;

    function get() public view returns (uint256) {
        return count;
    }

    function inc() public {
        count++;
    }
    function dec() public {
        count--;
    }
}
//原始数据类型
contract Primitives {
    bool public boo = true;
    uint8 public u8 = 1; //范围0~2**8-1
    uint256 public u256 = 456; //范围0~2**256-1
    uint public u = 123; //uint=uint256
    int8 public i8 = -1;
    int256 public i256 = 456;
    int public i = -123; //int=int256
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;
    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    bytes1 public a = 0xb5; //bytes=byte[]
    bool public defaultBoo; //默认false
    uint256 public defaultUint; //默认0
    int256 public defaultInt; //默认0
    address public defaultAddr; //默认0x0000000000000000000000000000000000000000
}
//变量
contract Variable {
    string public text = "Hello";
    uint256 public num = 123;

    function doSomething() public view {
        //  uint256 i = 456;
        // uint256 timestamp = block.timestamp;
        //  address sender = msg.sender;
    }
}

//常数
contract Constants {
    address public constant MY_ADDRESS =
        0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_UINT = 123;
    address public immutable ADDRESS; //空白常量
    uint256 public immutable UINT;
    constructor(uint256 _myUint) {
        ADDRESS = msg.sender;
        UINT = _myUint;
    }
}
//读取写入状态变量
contract SimpleStorage {
    uint256 public num;
    function set(uint256 _num) public {
        num = _num;
    }
    function get() public view returns (uint256) {
        return num;
    }
}
//ETH单位
contract EtherUints {
    uint256 public oneWei = 1 wei;
    bool public isOneWei = (oneWei == 1);
    uint256 public oneGwei = 1 gwei;
    bool public isOneGwei = (oneGwei == 1e9);
    uint256 public oneEther = 1 ether;
    bool public isOneEther = (oneEther == 1e18);
}
//映射
contract Mapping {
    mapping(address => uint256) public map;
    mapping(address => mapping(address => uint256)) public nestedMap;
    function get(address _addr) public view returns (uint256) {
        nestedMap[msg.sender][_addr];
        return map[_addr];
    }
    function set(address _addr, uint256 num) public {
        map[_addr] = num;
        nestedMap[msg.sender][_addr] = num;
    }
    function del(address _addr) public {
        delete map[_addr];
        delete nestedMap[msg.sender][_addr];
    }
}
//数组
contract Array {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    uint256[10] public fixedSizeArr;

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }
    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        delete arr[index];
    }

    function examples() external pure {
        //  uint256[] memory a = new uint256[](5);
    }

    function remove2(uint256 index) public {
        for (uint256 i = index; i < arr.length; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
    function remove3(uint256 index) public {
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}
//枚举
contract Enum {
    enum Status {
        OP,
        EN,
        PA,
        WF,
        SF
    }
    Status public status;

    function get() public view returns (Status) {
        return status;
    }
    function set(Status _status) public {
        status = _status;
    }

    function en() public {
        status = Status.EN;
    }
    function reset() public {
        delete status;
    }
}
//结构体
contract Struct {
    struct A {
        string text;
        bool completed;
    }

    A public a;
    function set() public {
        a = A("123", true);
        a = A({text: "456", completed: false});
    }
    function get() public view returns (string memory text, bool completed) {
        return (a.text, a.completed);
    }
}

//数据位置
contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;
    struct MyStruct {
        uint256 foo;
    }

    function f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {

    }

    function g(uint256[] memory _arr)public returns(uint256[] memory){

    }

    function h(uint256[] calldata _arr) external{

    }
}
//函数
contract Function {

    function returnMany() public pure returns (uint256, bool, uint256) {
        return (1, true, 2);
    }


    function named() public pure returns (uint256 x, bool b, uint256 y) {
        return (1, true, 2);
    }


    function assigned() public pure returns (uint256 x, bool b, uint256 y) {
        x = 1;
        b = true;
        y = 2;
    }

  
    function destructuringAssignments()
        public
        pure
        returns (uint256, bool, uint256, uint256, uint256)
    {
        (uint256 i, bool b, uint256 j) = returnMany();

    
        (uint256 x,, uint256 y) = (4, 5, 6);

        return (i, b, j, x, y);
    }


    function arrayInput(uint256[] memory _arr) public {}


    uint256[] public arr;

    function arrayOutput() public view returns (uint256[] memory) {
        return arr;
    }
}
//错误
contract Error {
    function testRequire(uint256 _i) public pure {

        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
 
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
    
        assert(num == 0);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}
//函数修饰符
contract FunctionModifier {

    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}
//事件
contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}

contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}


contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract B is X("Input to X"), Y("Input to Y") {}

contract C is X, Y {

    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}


contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}