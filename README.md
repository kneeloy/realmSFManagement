# realmSFManagement
-----------------------------
This repo contains a simple realmsync based app for iOS that can synchronise the salesForce data between devices/users via Realm Object Server.

# Prerequisites
----------------------------

XCode 11
Cocoapods
Realm Object Server/Cloud

# SetUp
--------------------------

In a new terminal window, clone this repo and run pod install --repo-update to update and install the required Realm SDK.
Open RealmSFManagement.xcworkspace with Xcode.
Locate the Constants.swift file in the file navigator; Edit it and replace MY_INSTANCE_ADDRESS with your Cloud Instance Address.
