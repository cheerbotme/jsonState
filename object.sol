// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10
;
contract objectState {
    error NotAdmin()
    ; error NoValue()
    ; error NoKey()
    ; error NoCount()
    ; error NoList()
    ; error CurrentValue()
    ; error KeyValueLengthMismatch()
    ;
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
        if ( count >= adminCount ) revert NotAdmin()
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
        ; if (
            key.length != value.length
            ) revert KeyValueLengthMismatch()
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
        if (
            keccak256( bytes( key ) )
            == keccak256( bytes( "" ) )
            ) revert NoKey()
        ; if (
            keccak256( bytes( value ) )
            == keccak256( bytes( "" ) )
            ) revert NoValue()
        ; (
            uint index
            , uint version
        ) = newKeyTest( key )
        ;
        if ( version > 0 ) {
            if (
                keccak256( bytes( value ) )
                == keccak256( bytes( 
                    KeyValue[ key ][ version -1 ].value 
                ) )
                ) revert CurrentValue()
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
        if (
            keyCount == 0
            ) revert NoCount()
        ; return keyCount -1
        ;
    }
    function KeyString() public view returns ( string memory ) {
        if (
            bytes( keyString ).length == 0
            ) revert NoList()
        ; return keyString
        ;
    }
}
