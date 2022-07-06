pragma solidity ^0.5.0;


contract Banks{

 //   Bank[] banks;
  //  uint256 public bankCount=0;

    //Initializing the admin to hold the address of he admin
    address admin;
 
    enum Status {ACTIVATE_NEW_CUSTOMER,ACTIVATE_FOR_KYC,BLOCK_FOR_NEW_CUSTOMER,BLOCK_FOR_KYC,PENDING}

    struct Bank {
        string bname;  //Name of the bank
        address bAddress; // unique Ethereum address of the bank     
        bool allowedForNewCustomer;
        bool allowedToPerformKYC;
    } 
    enum CustKycStatus {COMPLETED,PENDING,IN_PROGRESS}
    struct Customer{
        string cName;
        string dataHash;
        address bAddress;

    }

    mapping(address => Bank ) public banks;
    mapping(string => Customer ) public customers;
    mapping(string => Customer) public requests;

    uint256 custCount=0;
    constructor() public{
        admin=msg.sender;
    }

    function incrementCount() internal{
        custCount ++;
    }
    
    //Verify of the user trying to call this function is admin or not
    modifier onlyAdmin(){
        require(msg.sender == admin);
        _;
    }
    
    function addNewBank(string memory bankName,address bankAddress) public payable onlyAdmin{ 
        banks[bankAddress] = Bank(bankName, bankAddress,false,false);
    }

    function addNewCustomer(string memory cName,string memory dataHash)public payable {
        if(banks[msg.sender].allowedForNewCustomer==true){
            customers[cName]= Customer(cName,dataHash,msg.sender);
        }
    }

    uint kycRequest=0;
    function performKYC(string memory custName) public{
        if(banks[customers[custName].bAddress].allowedToPerformKYC==true){
            kycRequest++;
            requests[kycRequest] = customers[custName];
        }
    }
    function removeForKYC(string memory custName) public{
        requests
    }

    function activateBank(address bAddress) public onlyAdmin{
        banks[bAddress].allowedForNewCustomer=true;
        banks[bAddress].allowedToPerformKYC=true;
    }
    function blockBankForNewCustomer(address bAddress) public onlyAdmin {
        banks[bAddress].allowedForNewCustomer=false;
    }
    function activateBankForNewCustomer(address bAddress) public onlyAdmin{
        banks[bAddress].allowedForNewCustomer=true;
    }
    function blockBankToPerformKYC(address bAddress) public onlyAdmin{
        banks[bAddress].allowedToPerformKYC=false;
    }
    function activateBankToPerformKYC(address bAddress) public onlyAdmin{
        banks[bAddress].allowedToPerformKYC=true;
    }
   
}


