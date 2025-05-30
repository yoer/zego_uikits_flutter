- [中文](README.zh.md)
- [हिन्दी](README.hi.md)

# Code Structure

```
lib/
├── app.dart                 # Application entry and global configuration
├── main.dart               # Main program entry
├── firebase_options.dart   # Firebase configuration
├── common/                 # Common components and utilities
├── data/                   # Data models and state management
├── firestore/             # Firestore database operations
├── kits/                  # ZEGO UI Kits integration
│   ├── call/             # Call functionality
│   │   ├── call_page.dart        # Call page
│   │   ├── call_invitation.dart  # Call invitation
│   │   └── call_settings.dart    # Call settings
│   ├── live_streaming/   # Live streaming functionality
│   │   ├── live_page.dart       # Live page
│   │   ├── pk_page.dart         # PK functionality
│   │   └── live_settings.dart   # Live settings
│   ├── audio_room/       # Audio chat room
│   │   ├── audio_room_page.dart    # Audio room page
│   │   └── audio_room_settings.dart # Audio room settings
│   ├── conference/       # Video conference
│   │   ├── conference_page.dart    # Conference page
│   │   └── conference_settings.dart # Conference settings
│   ├── chat/             # Instant messaging
│   │   ├── chat_page.dart      # Chat page
│   │   └── chat_settings.dart  # Chat settings
│   ├── cache.dart        # Cache management
│   ├── room_list.dart    # Room list management
│   ├── express_event_handler.dart # Event handling
│   └── kits_page.dart    # Kits page management
└── pages/                # Page components
    ├── splash.dart       # Splash page
    ├── loading.dart      # Loading page
    ├── login.dart        # Login page
    ├── home.dart         # Home page
    ├── settings.dart     # Settings page
    ├── about.dart        # About page
    ├── contact.dart      # Contact page
    ├── feedback.dart     # Feedback page
    ├── more_drawer.dart  # More drawer menu
    └── utils/            # Page utilities
        └── ...          # Page-related utility functions and components
```

# Introduction

demo of zego-uikits

- [call](https://pub.dev/packages/zego_uikit_prebuilt_call)
- [live](https://pub.dev/packages/zego_uikit_prebuilt_live_streaming)
- [audio room](https://pub.dev/packages/zego_uikit_prebuilt_live_audio_room)
- [conference](https://pub.dev/packages/zego_uikit_prebuilt_video_conference)
- [chat](https://pub.dev/packages/zego_zimkit)

The demo introduces the basic functions of five kits, linking virtual users together simply through Firestore.

A purely personal project powered by love:
1. No version plans, please like and encourage.
2. No technical support, please raise issues for bugs and feature requests.

# Getting Started

Before using, you need to register Firestore and ZEGO AppID/AppSign.

1. Firestore

   - Related Features: Contacts, Live PK host list
   - Set up Firebase project:
     - Create a Firebase project:
       Visit [Firebase Console](https://console.firebase.google.com/u/0/) and create a new project.
     - Enable Firestore:
       In the project, navigate to the "Firestore Database" section, select Create Database, and then select Start in Test Mode.
       Set the rules on the rules page:
       ```terminal
       rules_version = '2';

       service cloud.firestore {
           match /databases/{database}/documents {
               match /{document=**} {
               allow read, write: if true;
               }
           }
       }
       ```
   - Download your own Google services file, then replace `./android/app/google-services.json` and `./ios/Runner/GoogleService-Info.plist` respectively.
   - follow the instructions on [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=ios)
2. AppID/AppSign of Zego
   Go to [ZEGOCLOUD Admin Console](https://console.zegocloud.com/), get the appID and appSign of your project.
   Then set it in the demo's system settings interface.
3. Configure Offline Calls (Optional)
   Please follow the steps in **1. Firebase Console and ZEGO Console Configuration** section of [Configure your project](https://www.zegocloud.com/docs/uikit/callkit-flutter/quick-start-(with-call-invitation)#configure-your-project).

# Feature Introduction

## splash
  A brief introduction to the basic functions of the five kits.
  <div style="overflow-x: auto; white-space: nowrap;">
        <img src="images/splash_1.png" alt="Splash 1" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_2.png" alt="Splash 2" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_3.png" alt="Splash 3" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_4.png" alt="Splash 4" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_5.png" alt="Splash 5" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_6.png" alt="Splash 6" style="width: 200px; display: inline-block; margin-right: 10px;">
    </div>

## global settings
  You need to set **ZEGO AppID/AppSign** here, and you can also **switch languages** here.
  <div style="overflow-x: auto; white-space: nowrap;">
        <img src="images/system_settings_1.png" alt="system settings" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/system_settings_2.png" alt="system settings" style="width: 200px; display: inline-block; margin-right: 10px;">
    </div>

## call
  
- Settings
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_7.png" alt="Call" style="width: 150px;">
            <div>Click the settings button in the upper right corner to enter the settings interface, where you can make some dynamic configurations.</div>
        </div>
    </div>

- Call Invitation

  - Dial Call
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_1.png" alt="Call" style="width: 150px;">
            <div>Call the other party by direct dialing.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_8.png" alt="Call" style="width: 150px;">
            <div>Calling interface (caller).</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_10.png" alt="Call" style="width: 150px;">
            <div>Calling interface (recipient).</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_11.png" alt="Call" style="width: 150px;">
            <div>Calling interface (recipient).</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_2.png" alt="Call 2" style="width: 150px;">
            <div>Press the " # " key to increase the number of callers for a group call.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_3.png" alt="Call" style="width: 150px;">
            <div>Group calling interface (caller).</div>
        </div>
    </div>

  - Call History
  - Contacts
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_6.png" alt="Call" style="width: 150px;">
            <div>Directly call back the other party from the call log.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_9.png" alt="Call" style="width: 150px;">
            <div>Directly call the other party from the contacts in the top toolbar.</div>
        </div>
    </div>

- 1v1/group
  - Preset Call Room List
    You can configure the call room list in the call settings page, and those entering the same call can converse with each other.
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_4.png" alt="Call" style="width: 150px;">
            <div>Directly enter the preset call (1v1) from the preset call list.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_5.png" alt="Call" style="width: 150px;">
            <div>Directly enter the preset call (group) from the preset call list.</div>
        </div>
    </div>

- live
  - Live Streaming
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_0.png" alt="live" style="width: 150px;">
            <div>Preset live list.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_1.png" alt="live" style="width: 150px;">
            <div>Host preview page.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_2.png" alt="live" style="width: 150px;">
            <div>Beauty filter.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_3.png" alt="live" style="width: 150px;">
            <div>Co-host.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_3_2.png" alt="live" style="width: 150px;">
            <div>Member list.</div>
        </div>
    </div>
  - PK
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_4.png" alt="live" style="width: 150px;">
            <div>Online idle host list.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_5.png" alt="live" style="width: 150px;">
            <div>Host invited for PK.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_6.png" alt="live" style="width: 150px;">
            <div>Some host status shows PK invitation in progress.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_7.png" alt="live" style="width: 150px;">
            <div>Some host status shows PK in progress.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_8.png" alt="live" style="width: 150px;">
            <div>Default PK interface.</div>
        </div> 
    </div>
  - Live List
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_9.png" alt="live" style="width: 150px;">
        </div>
    </div>
  - Swipe Switching
  - Multimedia Sharing
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_10.png" alt="live" style="width: 150px;">
            <div>Host shares a movie.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_11.png" alt="live" style="width: 150px;">
            <div>Audience watches the host explain the movie.</div>
        </div>
    </div>

- audio room
  - Preset Room List
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_1.png" alt="audio room" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_2.png" alt="audio room" style="width: 150px;">
        </div>
    </div>
  - Multimedia Sharing
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_5.png" alt="audio room" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_3.png" alt="audio room" style="width: 150px;">
            <div>Host plays a movie.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_4.png" alt="audio room" style="width: 150px;">
            <div>Other users.</div>
        </div>
    </div>

- conference
  - Preset Room List
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_0.png" alt="conference" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_1.png" alt="conference" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_2.png" alt="conference" style="width: 150px;">
            <div>Chat interface.</div>
        </div>
    </div>
  - Screen Sharing
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_3.png" alt="conference" style="width: 150px;">
            <div>Watch someone else's screen sharing.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_4.png" alt="conference" style="width: 150px;">
            <div>Currently sharing screen.</div>
        </div>
    </div>

- chat
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/chat_1.png" alt="chat" style="width: 150px;">
            <div>Select contacts from the address book.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/chat_2.png" alt="chat" style="width: 150px;">
            <div>Received messages from other users.</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/chat_3.png" alt="chat" style="width: 150px;">
            <div>Message list.</div>
        </div>
    </div>