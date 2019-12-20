---
layout: post
title: Firebase Auth State Listeners iOS
hide_title: true
tags: [Realm, Swift, iOS]
excerpt: Receive notification when firebase users auth state changes on iOS.
author: thecoolwinter
published: true
---

### Firebase auth lets you pass a handler function when the auth state changes.

In my use case I need to receive state change alerts. My user might be disabled by an admin or a bot, or the account is stopped for security reasons. But, I need to update user interfaces and data code to match that the user is logged out.

#### Fortunately its easy with firebase

Somewhere in your startup code -I use a container view for all my views, but the AppDelegate or SceneManager works well here- put this snippet in.

```swift
func setAuthListener() {
		Auth.auth().addStateDidChangeListener { (auth, user) in
			if user == nil {
				// The user is either logged out, or something went wrong. 
        // You can use the Auth.auth().currentUser.reload() function 
        //	 to try to find the error using the FIRErrorCode enum
			}
			
		}
	}
```

Then just fire that function somewhere at the start of your app.