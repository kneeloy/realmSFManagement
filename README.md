# RealmSFManagement
-----------------------------
This repo contains a simple realmsync based app for iOS that can synchronise the salesForce data between devices/users via Realm Object Server.

# Prerequisites
----------------------------

XCode 11<br />
Cocoapods<br />
Realm Object Server/Cloud<br />

# SetUp
--------------------------

In a new terminal window, clone this repo and run pod install --repo-update to update and install the required Realm SDK.<br />
Open RealmSFManagement.xcworkspace with Xcode.<br />
Locate the Constants.swift file in the file navigator; Edit it and replace MY_INSTANCE_ADDRESS with your Cloud Instance Address.

# Functionalities
----------------------------
This app covers several introductory concepts about Realm.<br />
  i.e Add, Update and Delete records<br />
  Sync mechanism<br />
  Backlink - demonstrates how to define models with inverse relationships using linkingObjectsOfClass(_:forProperty:)
  
# Roadmaps
----------------------------
Demonstrate realm migration feature<br />
Custom conflict resolution rules(on the server side)<br />
Introduce Protocol oriented MVVM architecture to avoid the bottleneck/closed couple nature of realm object and UI in current version of the App to provide further flexibilty and reusability<br />

