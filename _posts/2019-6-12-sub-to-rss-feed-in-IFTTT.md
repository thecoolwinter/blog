---
layout: post
title: Sending firebase notifications for an RSS post
hide_title: true   
tags: [IFTTT, Firebase, Firebase Functions]
excerpt: Use webhooks and cloud functions to automate notifications for your favorite blog.
author: thecoolwinter
published: false
---
# Sending firebase notifications for an RSS post
### Use webhooks and cloud functions to automate notifications for your favorite blog.

I had an idea, my favorite author (Patrick Rothfus) is currently writing his next book. I was bored, so I decided to create an app to send me a notification when he posted his next blog post. To accomplish this I decided to use a combination of two free services: Google Firebase and IFTTT.

[IFTTT](https://ifttt.com/) (IF This Then That) is a sevice that allows you to set up events (If This) with triggers (Then That), these can be things like an Alexa command, a Twitter feed update, or a new RSS blog post. 

[Google Firebase](firebase.google.com) is a PAAS (platform-as-a-service) that brings massive cloud  functionality to mobile and web apps. Major apps like Duolingo and Twitter use them as the backend for their mobile and web apps. Firebase offers a very good free level for projects, which is what we're going to use. The two services that we're going to use are: [Cloud Functions](firebase.google.com/functions) and [Cloud Messaging](firebase.google.com/messaging). Cloud functions allow us to perform server logic on an event, like a database entry or HTTP request. Cloud Messaging is a completely free push notification platform that is part of the Firebase ecosystem.

To combine these two services we'll use a webhook in IFTTT to send an HTTP request to firebase, which will fire a function to send notifications to an app.

There will only be three steps to this project:

1. Write a Cloud Function to send notifications
2. Setup IFTTT with a webhook linking to a cloud function
3. Upload the Cloud Function and test it

## To get started with Firebase go to [this link](https://firebase.google.com/) and login with a Google account.

Click on the 'Go to console' button in the top right corner and create a project. Enter in all the fields and name it whatever you'd like.

Now that you have a project started, you should see a screen like this one:

![2019-6-12-firebaseHome](/Users/khan/Desktop/blog/assets/img/posts/2019-6-12-firebaseHome.png)

Head to Functions in the left-hand menu.

## Next, go to [IFTTT](https://ifttt.com/) and create an account. Then, create a new applet. Then, search for the RSS applet functionality and add it to the applet.

You should be at this page:

![New IFTTT Applet](/Users/khan/Desktop/blog/assets/img/posts/2019-6-12-newApplet.png)

Next, add an event by pressing 'this'.

Search for RSS and click on the resulting category to add it. You should see an option that says 'New Feed Item'. Click on it.

Then enter in the url of your RSS feed. Like so:

![2019-6-12-rssApplet](/Users/khan/Desktop/blog/assets/img/posts/2019-6-12-rssApplet.png)

Then create the trigger.

### 
