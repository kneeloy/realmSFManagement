# RealmSFManagement
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

# Functionalities
----------------------------
This app covers several introductory concepts about Realm.
  i.e Add, Update and Delete records
  Sync mechanism
  Backlink - demonstrates how to define models with inverse relationships using linkingObjectsOfClass(_:forProperty:)
  
# Roadmaps
----------------------------
Demonstrate realm migration feature
Custom conflict resolution rules(on the server side)
Introduce Protocol oriented MVVM architecture to avoid the bottleneck/closed couple nature of realm object and UI in current version of the App to provide further flexibilty and reusability

