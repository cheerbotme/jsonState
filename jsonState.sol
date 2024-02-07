/**
 *Submitted for verification at sepolia-optimism.etherscan.io on 2023-12-27
*/

// SPDX-License-Identifier: MIT
// by besta.pe
pragma solidity ^0.8.19
;
contract jsonState {
    function KeyValue(
        string[] calldata key
        , string[] calldata value
        , bool newKeysOnly
    ) external {
        ifAdmin()
        ; uint count
        ; Change = false
        ; Replace = true
        ;
        if ( key.length != value.length ) {
            revert KeyValueNotBijective()
            ;
        }
        if ( newKeysOnly ){
            Replace = false
            ;
        }
        while( count < key.length ) {
            addKeyValue(
                key[ count ]
                , value[ count ]
            )
            ; count ++
            ;
        }
        if ( ! Change ) {
            revert NoChange()
            ;
        }
    }
    function JSON() public view returns (
        string memory
    ) {
        if ( KeyCountPlus1 == 0 ) {
            revert NoKey()
            ;
        }
        uint count
        ; string memory json = "{"
        ;
        while ( count < KeyCountPlus1 ) {
            string memory key = keyIndex[ count ].key
            ; uint version = keyIndex[ count ].version
            ; string memory value = keyValue[ 
                key ][ version 
            ].value
            ; json = string.concat(
                    json
                    , "\""
                    , key
                    , "\":\""
                    , value
                    , "\""
                )
            ;
            if ( count < KeyCountPlus1 -1 ) {
                json = string.concat(
                    json
                    , ","
                )
                ;
            }
            count++
            ;
        }
        return string.concat(
            json
            , "}"
        )
        ;
    }
    function LatestVersion(
        string calldata key
    ) public view returns ( uint ) {
        uint count
        ;
        if ( KeyCountPlus1 == 0 ) {
            revert NoKey()
            ;
        }
        while ( count < KeyCountPlus1 ) {
            if ( 
                keccak256( bytes( key ) )
                == keccak256( 
                    bytes( keyIndex[ count ].key ) 
                ) 
            ) {
                    return keyIndex[ count ].version
                    ;
            }
            count ++
            ;
        }
        revert NoKey()
        ;
    }
    function TotalKeys() public view returns (
        uint
    ) {
        if ( KeyCountPlus1 == 0 ) {
            revert NoKey()
            ;
        }   
        return KeyCountPlus1
        ;
    }
    function Value(
        string calldata key
        , uint version
    ) public view returns ( string memory ) {
        string memory value = keyValue[
            key ][ version
        ].value
        ;
        if (
            keccak256( bytes( value ) )
            == keccak256( bytes( "" ) )
        ) { 
            revert NoValue()
            ;
        }
        return value
        ;
    }
    function addKey( string calldata key ) internal {
        KeyCountPlus1 ++
        ; keyIndex[ KeyCountPlus1 -1 ] = keyMap(
            key
            , 0
        )
        ;
    }
    function addKeyValue(
        string calldata key
        , string calldata value
    ) internal {
        if (
            keccak256( bytes( key ) )
            == keccak256( bytes( "" ) )
        ) { 
            revert NoKey()
            ;
        }
        if (
            keccak256( bytes( value ) )
            == keccak256( bytes( "" ) )
        ) { 
            revert NoValue()
            ;
        }
        (
            uint index
            , uint version
        ) = newKeyTest( key )
        ;
        if ( version > 0 ) {
            if (
                keccak256( bytes( value ) )
                == keccak256( bytes( 
                    keyValue[ key ][ version -1 ].value 
                ) )
            ) {
                return
                ;
            }
            keyIndex[ index ].version += 1
            ;
        }
        keyValue[ key ][ version ] = versionMap( value )
        ; Change = true
        ;
    }
    function ifAdmin() internal view {
        if ( msg.sender == Admin ) {
            return
            ;
        }
        revert NotAdmin()
        ;
    }
    function newKeyTest(
        string calldata key
    ) internal returns (
        uint
        , uint 
    ) {
        uint count
        ;
        while ( count < KeyCountPlus1 ) {
            if (
                keccak256( bytes( key ) )
                == keccak256(
                    bytes( keyIndex[ count ].key )
                )
            ) {
                if ( ! Replace ) {
                    revert NewKeysOnly()
                    ;
                }
                return (
                    count
                    , keyIndex[ count ].version +1
                )
                ;
            }
            count ++
            ;
        }
        addKey( key )
        ; Change = true
        ; return ( 0, 0 )
        ;
    }
    mapping(
        uint => keyMap
    ) private keyIndex
    ; mapping(
        string => mapping(
            uint => versionMap
        )
    ) private keyValue
    ;
    struct versionMap {
        string value
        ;
    }
    struct keyMap {
        string key
        ; uint version
        ;
    }
    error KeyValueNotBijective()
    ; error NewKeysOnly()
    ; error NoChange()
    ; error NoKey()
    ; error NotAdmin()
    ; error NoValue()
    ; address Admin
    ; bool Change
    ; uint KeyCountPlus1
    ; bool Replace
    ;
    constructor() {
        Admin = 0x2ceEC83333c7d987C329164b8e85135dC1232b84
        ;
    }
}
