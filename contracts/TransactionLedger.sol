pragma solidity ^0.8.0;

contract TransactionLedger {
    struct Transaction {
        uint256 id;
        address sender;
        address recipient;
        uint256 amount;
        uint256 timestamp;
        string description;
        string currencyType;
        uint256 exchangeRate;
    }

    Transaction[] public transactions;

    mapping(address => bytes32) private userKeys;

    modifier onlyLoggedIn() {
        require(
            userKeys[msg.sender] != 0x0,
            "You must log in before accessing this function."
        );
        _;
    }

    function login(bytes32 _hashedKey) public {
        userKeys[msg.sender] = _hashedKey;
    }

    function addTransaction(
        address _sender,
        address _recipient,
        uint256 _amount,
        string memory _description,
        string memory _currencyType,
        uint256 _exchangeRate
    ) public onlyLoggedIn {
        transactions.push(
            Transaction(
                transactions.length + 1,
                _sender,
                _recipient,
                _amount,
                block.timestamp,
                _description,
                _currencyType,
                _exchangeRate
            )
        );
    }

    function getTransactionCount() public view onlyLoggedIn returns (uint256) {
        return transactions.length;
    }

    function getTransaction(uint256 _index)
        public
        view
        onlyLoggedIn
        returns (
            uint256,
            address,
            address,
            uint256,
            uint256,
            string memory,
            string memory,
            uint256
        )
    {
        Transaction memory t = transactions[_index];
        return (
            t.id,
            t.sender,
            t.recipient,
            t.amount,
            t.timestamp,
            t.description,
            t.currencyType,
            t.exchangeRate
        );
    }

    function getAllTransactions()
        public
        view
        onlyLoggedIn
        returns (Transaction[] memory)
    {
        return transactions;
    }

    function getTransactionsBySender(address _sender)
        public
        view
        onlyLoggedIn
        returns (Transaction[] memory)
    {
        uint256 count = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].sender == _sender) {
                count++;
            }
        }

        Transaction[] memory result = new Transaction[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].sender == _sender) {
                result[index] = transactions[i];
                index++;
            }
        }

        return result;
    }

    function getTransactionsByReceiver(address _receiver)
        public
        view
        onlyLoggedIn
        returns (Transaction[] memory)
    {
        uint256 count = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].recipient == _receiver) {
                count++;
            }
        }

        Transaction[] memory result = new Transaction[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].recipient == _receiver) {
                result[index] = transactions[i];
                index++;
            }
        }

        return result;
    }
}
