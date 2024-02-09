# jsonState.sol
Keep the network JSON, with a state-focus.

Object state-changer on line 254.

## UX

Visit https://cheerbotme.github.io/jsonState/ to use it, though you won't have write permissions with the default contract.

On https://chainid.link/?network=op-sepolia network.

![image](https://github.com/cheerbotme/jsonState/assets/3211305/8435f0eb-3527-4664-8f76-60eec2961605)

## what

![image](https://github.com/cheerbotme/jsonState/assets/3211305/58593e03-f732-4cf5-8f2a-cd45b79a8095)

E.g.:

https://sepolia-optimistic.etherscan.io/address/0x0f2c3af6b686d9a8e67b17fd3888d48df57dfbd2#readContract

![image](https://github.com/cheerbotme/jsonState/assets/3211305/bea04cd9-330f-4efe-a006-d06d1ad1dba2)

https://sepolia-optimistic.etherscan.io/address/0x0f2c3af6b686d9a8e67b17fd3888d48df57dfbd2#writeContract

![image](https://github.com/cheerbotme/jsonState/assets/3211305/64226c91-1a5a-4e8f-b309-8d47dcfeb2cd)

## index.html

read and write to jsonState.

## host.js

localhost runtime to edit `index.html`.

# object.sol (depreciated)
Generalized object store in Solidity with versioning for state change on the blockchain. 

Develop a smart contract as minimal as possible that can store any stateful object.

## why?

Based on this idea while working on Gitcoin comic #3

<p align="left">

   <img src="https://user-images.githubusercontent.com/3211305/152414831-0bb0fe40-52bf-402f-a61f-2745a4f5786d.png" width="50%">

</p>

## current working version

https://rinkeby.etherscan.io/address/0x295c006cfecb8c8f2f6e0911b6983d2cac758b26#code

<p align="left">

   <img src="https://user-images.githubusercontent.com/3211305/151673666-ad365d08-29bb-4707-8e54-139b4011e7a8.png">

</p>

## to do

Pull requests welcome!

[x] create minified version

[x] separate contract specific logic from generic logic

[x] optimize gas efficiency

[x] create JavaScript interface!
