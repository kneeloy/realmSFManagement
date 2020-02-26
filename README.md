# RealmSFManagement
-----------------------------
This repo contains a simple realmsync based app for iOS that can synchronise the custom SalesForceActivityManagement data between devices/users via Realm Object Server.

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
This app covers several introductory concepts about Realm i.e<br />
  Add, Update and Delete records<br />
  Fetch realm and using filters<br />
  Sync mechanism<br />
  Realm Notifications<br />
  Backlink - demonstrates how to define models with inverse relationships using linkingObjectsOfClass(_:forProperty:)
  
# Known Issue
----------------------------
On the initial cold launch of the app (the app is being launched for the first time on the device and does not have nY initial data synced in the local database) the data sync is not working upon first login attempt.<br />
  Workaround steps:<br />
  During cold launch of the app after successful on first login attempt the Route screen will not contain any data<br />
  Now please 'Logout' of the app and L'ogin' again with the same user credential<br />
  Data now shold be synced and being displayed in the route screen.
  
# Roadmaps
----------------------------
Demonstrate realm migration feature<br />
Custom conflict resolution rules(on the server side)<br />
Introduce Protocol oriented MVVM architecture to avoid the bottleneck/closed couple nature of realm object and UI in current version of the App to provide further flexibilty and reusability<br />

