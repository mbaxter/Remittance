Purpose
===

This is a simple practice project put together while learning Solidity.

Problem Description
===
Build a 'Remittance' contract to where:
* A sender can lock funds into the contract and set a deadline after which funds can be reclaimed.
* Set a recipient who can withdraw the funds if they supply the right password before the deadline.

The idea is as follows.  Say Alice wants to send funds to Bob.  But alice only has ether and Bob wants dollars.
A third person, Carol, runs and exchange where she can receive ether and disburse cash.  

With this contract, Alice can create a new Remittance that stores a certain amount of ether.  She
gives a password to Bob.  When Bob and Carol meet to complete the exchange, Carol will send a transaction
to the contract with Bob's password.  Carol gets the ether, and will then release the cash to Bob.

Technology
===
This contract was built for deployment on the ethereum network using [Truffle](http://truffleframework.com/).