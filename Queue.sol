pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
    string[] public queue;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
	require(msg.pubkey() == tvm.pubkey(), 102);
	tvm.accept();
	_;
    }

    function enqueue(string name) public checkOwnerAndAccept {
        queue.push(name);
    }

    function dequeue() public checkOwnerAndAccept {
        require(queue.length != 0, 105, "Queue is empty.");
        if (queue.length == 1)
            queue.pop();
        else
        {
            for (uint i = 0; i < queue.length - 1; ++i)
                queue[i] = queue[i + 1];
            queue.pop();
        }
    }
}