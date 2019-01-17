#!/bin/sh

# CA
cp -Rf /app/fabric-samples/basic-network/crypto-config/peerOrganizations/org1.example.com/ca/* /opt/volumes/ca-persistentvolumeclaim/
# ORDERER
cp -Rf /app/fabric-samples/basic-network/config/* /opt/volumes/orderer-1-persistentvolumeclaim/
cp -Rf /app/fabric-samples/basic-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/* /opt/volumes/orderer-2-persistentvolumeclaim/
cp -Rf /app/fabric-samples/basic-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/* /opt/volumes/orderer-3-persistentvolumeclaim/
# PEER
# /opt/volumes/peer-1-persistentvolumeclaim/ NOTHING TO DO ???
cp -Rf /app/fabric-samples/basic-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/* /opt/volumes/peer-2-persistentvolumeclaim/
cp -Rf /app/fabric-samples/basic-network/crypto-config/peerOrganizations/org1.example.com/users/* /opt/volumes/peer-3-persistentvolumeclaim/
cp -Rf /app/fabric-samples/basic-network/config/* /opt/volumes/peer-4-persistentvolumeclaim/
# EXPLORER
cp -Rf /app/fabric-samples/basic-network/crypto-config/* /opt/volumes/explorer-1-persistentvolumeclaim/

exit 0
