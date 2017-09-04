pragma solidity ^0.4.4;

import "./Owned.sol";

contract Remittance is Owned {

	enum State { PENDING, COMPLETE, RECLAIMED }

	State state;
	uint public amount;
	address exchange;
	bytes32 passwordHash;
	uint public deadlineBlockNumber;
	int public failedPasswordAttempts;

	modifier assertFromExchange() {

		require(msg.sender == exchange);
		_;
	}

	event LogFundsWithdrawn(address _exchange, uint _amount);
	event LogFundsReclaimed(address _owner, uint _amount);

	function Remittance(address _exchange, bytes32 _passwordHash, uint _deadlineInBlocks)
	payable
	{
		require(msg.value > 0);
		require(_exchange != address(this));
		require(_exchange != owner);

		state = State.PENDING;
		amount = msg.value;
		exchange = _exchange;
		passwordHash = _passwordHash;
		deadlineBlockNumber = block.number + _deadlineInBlocks;
	}

	function withdrawFunds(string password)
		public
		assertFromExchange
		returns (bool success)
	{
		// Check state
		require(state == State.PENDING);
		require(!isDeadlinePassed());
		// Check password
		require(sha256(password) == passwordHash);
	
		// Update state
		state = State.COMPLETE;
		// Execute withdrawal
		exchange.transfer(amount);
		LogFundsWithdrawn(exchange, amount);

		return true;
	}

	function reclaimFunds()
		public
		assertFromOwner
		returns (bool success)
	{
		// Check state
		require(state == State.PENDING);
		require(isDeadlinePassed());
		// Update state
	    state = State.RECLAIMED;
		// Execute transfer
		owner.transfer(amount);
		LogFundsReclaimed(owner, amount);

		return true;
	}

	function isDeadlinePassed()
		public
		constant
		returns (bool hasPassed)
	{
		return block.number > deadlineBlockNumber;
	}

	// Disable fallback
	function() {
		assert(false);
	}
}