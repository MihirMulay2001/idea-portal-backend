//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/interfaces/IERC721.sol";

contract IdeaPortal {
    struct Idea {
        uint16 id;
        uint16 votes;
        string idea;
        address user;
    }
    address buildspaceContract = 0x3CD266509D127d0Eac42f4474F57D0526804b44e;
    uint16 public numOfIdeas;
    mapping(address => uint256[]) ideas;
    mapping(uint256 => mapping(address => bool)) upvoters;
    Idea[] ideaList;

    event IdeaSet(
        uint16 indexed _id,
        uint16 _votes,
        string _idea,
        address indexed _from
    );

    event VoteChange(address indexed _from, bool status);

    function getIdeas() external view returns (Idea[] memory) {
        return ideaList;
    }

    function setIdea(string memory _idea) external {
        ideaList.push(Idea(numOfIdeas, 0, _idea, msg.sender));
        ideas[msg.sender].push(numOfIdeas);
        numOfIdeas++;
        emit IdeaSet(numOfIdeas - 1, 0, _idea, msg.sender);
    }

    function toggleVote(uint16 _id) external {
        if (checkIfUserUpvoted(_id)) {
            upvoters[_id][msg.sender] = false;
            ideaList[_id].votes--;
            emit VoteChange(msg.sender, false);
        } else {
            upvoters[_id][msg.sender] = true;
            ideaList[_id].votes++;
            emit VoteChange(msg.sender, true);
        }
    }

    function walletHoldsToken(address _wallet) public view returns (bool) {
        return IERC721(buildspaceContract).balanceOf(_wallet) > 0;
    }

    function checkIfUserUpvoted(uint16 _id) public view returns (bool) {
        return upvoters[_id][msg.sender];
    }

    function returnUserIdeas(address _user)
        public
        view
        returns (uint256[] memory)
    {
        return ideas[_user];
    }
    // function stringToBytes(string memory _idea)
    //     internal
    //     pure
    //     returns (bytes32)
    // {
    //     return bytes32(_idea);
    // }

    // function bytes32ToString(bytes32 _bytes32)
    //     public
    //     pure
    //     returns (string memory)
    // {
    //     uint8 i = 0;
    //     while (i < 32 && _bytes32[i] != 0) {
    //         i++;
    //     }
    //     bytes memory bytesArray = new bytes(i);
    //     for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
    //         bytesArray[i] = _bytes32[i];
    //     }
    //     return string(bytesArray);
    // }
}
