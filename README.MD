Coding Test (fictitious)


***
NOTE: PLEASE DO NOT USE THIRD PARTY LIBRARIES. However, feel free to state which third party libraries you might have used.
***

Here you'll find the code for a simple mobile app to browse cakes. 

Unfortunately, the developer who wrote this code is no longer employed by the company as we had some concerns over his ability. 

The project compiles but the app crashes as soon as it runs. The app loads a JSON feed containing a repeated list of cakes, with title, image and description from a URL, then displays the contents of the feed in a scrollable list. 

We would like you to fix the crash bug, ensure the functionality of the app works as expected (all images display correctly on the table, all text is readable) and performs smoothly (ideally, this should be done without third party libraries). You should also refactor, optimise and improve the code where appropriate to use platform best practises. 

Please note that we are not looking for perfection, but rather for a clean and pragmatic solution. This should include refactoring but shouldn’t be over engineered. The test can be completed in 2-3 hours; howerever, this is a not a limit. Feel free to spend more time on it if you wish.

## solution
### Introduction

I try to fix the application with the existing code structure. i.e the initial master code base. My solution fix the crash, show the data on the tableview properly and load the images asynchronous way unblocking the main thread. Currently, due to limited time this solution is only based on the deployment target iOS 11 i.e the latest version of the iOS only.

Structure wise I try to make the solution as simple as possible and follow MVC-S (Model-View-Controler and service). Although MVVM is the preffered way to do this but due to simplicity I have not done that.

### Development Platform
iOS 11 and XCode 9.2
Please note that the solution is based on iOS 11.0 and developed in XCode 9.2.

### Technology used
This is a mixed code base, I try to refactor the existing solution and build up the new refactored code in Swift 4.0 and iOS 11 . This solution include following features.

- Swift 4.0
- New way of Json serialization with codable protocol by Swift 4.
- Objective-c
- Unit Testing (TDD)

### How to run the solution
Please checkout or clone or download the .zip file from the GIT. Use XCode 9 or above  and iOS 11 to run the project.

### Area of improvment
I have not spent more than 3 hours for this assignment, if I spent few more hours I might provide few more unit tests. Although the assigment is not big enough but may be MVVM would be the better approch. Currently I try to implement the solution based on MVC-S (Model-View-Controller and Service) approach.

Currently the solution supports iOS 11 and upwords  for json serialization by using codable protocol. It is possible to give the support for the lower version of iOS by using "JSONSerialization.jsonObject".

### Known issue

[[BoringSSL] Function boringssl_session_errorlog: line 2871 [boringssl_session_read] SSL_ERROR_ZERO_RETURN(6): operation failed because the connection was cleanly shut down with a close_notify alert ]

This is an Xcode 9.2 - Swift 4 issue. This message is from the TLS layer and it’s related to how the TLS connection closes. Need few more investigation for this.






