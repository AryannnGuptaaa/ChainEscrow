// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {

    struct Project {
        address client;
        address freelancer;
        uint amount;
        bool isCompleted;
    }

    Project[] public projects;

    // Create a project and lock funds
    function createProject(address freelancer) public payable {
        require(msg.value > 0, "Send ETH");

        projects.push(Project({
            client: msg.sender,
            freelancer: freelancer,
            amount: msg.value,
            isCompleted: false
        }));
    }

    // Release payment to freelancer
    function releasePayment(uint projectId) public {
        Project storage project = projects[projectId];

        require(msg.sender == project.client, "Only client can release");
        require(!project.isCompleted, "Already completed");

        project.isCompleted = true;
        payable(project.freelancer).transfer(project.amount);
    }

    // View all projects
    function getProjects() public view returns (Project[] memory) {
        return projects;
    }
}