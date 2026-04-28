import { ethers } from "ethers";
import hre from "hardhat";

async function main() {
  const provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545");

  const signer = new ethers.Wallet(
    "0xf214f2b2cd398c806f84e317254e0f0b801d0643303237d97a22a48e01628897",
    provider
  );

  const artifact = await hre.artifacts.readArtifact("Escrow");

  const factory = new ethers.ContractFactory(
    artifact.abi,
    artifact.bytecode,
    signer
  );

  const contract = await factory.deploy();

  await contract.waitForDeployment();

  console.log("Contract deployed to:", await contract.getAddress());
}

main();