// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10
;
contract objectState {
    constructor() {
        AdminIndex[ 0 ].admin = tx.origin
        ;
    }
    //head_(permissions)
    function AddAdmin( address[] calldata hexidex ) external {
        uint count
        ;
        while( count < hexidex.length ) {
            addAdmin( hexidex[ count ] )
            ; count ++
            ;
        }
    }
    function addAdmin( address hexidex ) internal {
        ifAdmin()
        ; adminCount ++
        ; AdminIndex[ adminCount ] = adminMap( hexidex )
        ;
    }
    function ifAdmin() internal view {
        uint count
        ;
        while ( count < adminCount +1 ) {
            if ( msg.sender == AdminIndex[ count ].admin ) {
                return
                ;
            }
            count ++
            ;
        }
        require( count < adminCount, "NOT_ADMIN" )
        ;
    }
    uint adminCount
    ; struct adminMap {
        address admin
        ;
    }
    mapping( uint => adminMap ) public AdminIndex
    ;
    function AdminCount() public view returns ( uint ) {
        return adminCount
        ;
    }
    //body_(object)
    function AddKeyValue(
        string[] calldata key
        , string[] calldata value
    ) external {
        uint count
        ; require(
            key.length == value.length
            , "KEY_VALUE_NOT_BIJECTIVE"
        )
        ;
        while( count < key.length ) {
            addKeyValue(
                key[ count ]
                , value[ count ]
            )
            ; count ++
            ;
        }
    }
    function addKey( string calldata key ) internal {
        ifAdmin()
        ; keyCount ++
        ; KeyIndex[ keyCount -1 ] = keyMap(
            key
            , 0
        )
        ;
        if ( keyCount < 2 ) {
            keyString = string( abi.encodePacked( key ) )
            ; return
            ;
        }
        keyString = string( abi.encodePacked(
            keyString
            , ", "
            , key
        ) )
        ;
    }
    function addKeyValue(
        string calldata key
        , string calldata value
    ) internal {
        require(
            keccak256( bytes( key ) )
            != keccak256( bytes( "" ) )
            , "NO_KEY"
        )
        ; require(
            keccak256( bytes( value ) )
            != keccak256( bytes( "" ) )
            , "NO_VALUE"
        )
        ; (
            uint index
            , uint version
        ) = newKeyTest( key )
        ;
        if ( version > 0 ) {
            require(
                keccak256( bytes( value ) )
                != keccak256( bytes( 
                    KeyValue[ key ][ version -1 ].value 
                ) )
                , "CURRENT_VALUE"
            )
            ; KeyIndex[ index ].version += 1
            ;
        }
        KeyValue[ key ][ version ] = versionMap( value )
        ;
    }
    function newKeyTest( string calldata key ) internal returns (
        uint
        , uint 
    ) {
        uint count
        ; 
        while ( count < keyCount ) {
            if (
                keccak256( bytes( key ) )
                == keccak256( bytes( KeyIndex[ count ].key ) )
            ) {
                return (
                    count
                    , KeyIndex[ count ].version +1
                )
                ;
            }
            count ++
            ;
        }
        addKey( key )
        ; return ( 0, 0 )
        ;
    }
    uint keyCount
    ; string keyString
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
    mapping( 
        uint => keyMap 
    ) public KeyIndex
    ; mapping(
        string => mapping( 
            uint => versionMap 
        )
    ) public KeyValue
    ;
    function KeyCount() public view returns ( uint ) {
        require(
            keyCount > 0
            , "NO_COUNT"
        )
        ; return keyCount -1
        ;
    }
    function KeyString() public view returns ( string memory ) {
        require(
            bytes( keyString ).length > 0
            , "NO_LIST"
        )
        ; return keyString
        ;
    }
}
