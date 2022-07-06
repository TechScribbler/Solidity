pragma solidity ^0.5.0;


contract Customers{
  
    Customer[] customers;
    struct Customer{
        string uName;
        string dataHash;
        bool kycStatus;
        address bAddress;
    }
    function addNewCustomer(string memory uName, string memory dataHash) public {
            customers[0] =Customer (uName, dataHash,false,);
    }
}
