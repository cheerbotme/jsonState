# jsonState.sol
Keep the network JSON, with a state-focus.

Object state-changer on line 254 in jsonState.sol file.

![image](https://github.com/cheerbotme/jsonState/assets/3211305/58593e03-f732-4cf5-8f2a-cd45b79a8095)

## UX

Visit https://cheerbotme.github.io/jsonState/ to use it, though you won't have write permissions with the default contract.

On https://chainid.link/?network=op-sepolia network.

![image](https://github.com/cheerbotme/jsonState/assets/3211305/a04ba7bb-8e9f-43d1-a390-1e06bb307e99)

## what

E.g.:

https://sepolia-optimistic.etherscan.io/address/0x0f2c3af6b686d9a8e67b17fd3888d48df57dfbd2#readContract

![image](https://github.com/cheerbotme/jsonState/assets/3211305/bea04cd9-330f-4efe-a006-d06d1ad1dba2)

https://sepolia-optimistic.etherscan.io/address/0x0f2c3af6b686d9a8e67b17fd3888d48df57dfbd2#writeContract

![image](https://github.com/cheerbotme/jsonState/assets/3211305/64226c91-1a5a-4e8f-b309-8d47dcfeb2cd)

### state

Each value in the key is also a last-in-first-out index-array value.

E.g.: 

https://sepolia-optimistic.etherscan.io/address/0x0f2c3af6b686d9a8e67b17fd3888d48df57dfbd2#readContract

![photo_2024-02-08_21-25-05](https://github.com/cheerbotme/jsonState/assets/3211305/ffda39ae-be0d-41af-b083-d663d90503ff)

### nesting deeper

As a string, it is possible.

![image](https://github.com/cheerbotme/jsonState/assets/3211305/62460948-e57c-483e-9a6a-a3241aead12a)

But only the first nesting keeps an indexed state change.

![image](https://github.com/cheerbotme/jsonState/assets/3211305/8c2a521b-b6fe-4cdb-a835-c94bcb9a2185)

### NFT

Issues with permissions, but this is what it looks like.

![image](https://github.com/cheerbotme/jsonState/assets/3211305/2e2d3229-f01c-488e-963d-893e502553be)

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
