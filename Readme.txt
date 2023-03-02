Start Ganache

Compile the contract using the truffle compile command.

Deploy the contract to the Ganache network using the truffle migrate command.

After deployment, you can interact with the contract using the truffle console command.


// Load the contract instance
ledger = await TransactionLedger.deployed()

//Login using address 
await ledger.login("0x...")

// Add a new transaction
await ledger.addTransaction(accounts[0], accounts[1], 100, "Test Transaction","USD", 2)

// Get the number of transactions
await ledger.getTransactionCount()

// Get a specific transaction
await ledger.getTransaction(0)

// Get all transactions
await ledger.getAllTransactions()

// Get transactions where a given account was sender
await ledger.getTransactionsBySender(accounts[0])

// Get transactions where a given account was receiver
await ledger.getTransactionsByReceiver(accounts[1])