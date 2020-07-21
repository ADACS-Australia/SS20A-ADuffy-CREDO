
# Project Overview
This project converts the CREDO mobile detector from kotlin to flutter to make it availible on ios.
The app does records cosmic rays on older operating systems but struggles with more modern APIs.
A start has been made to utilize raw frames to resolve this problem however this work is as of yet incomplete and untested.

# Requirements

- Android Studio with working Flutter installation
- Xcode and command line tools for testing on ios

# Setup
- copy repository
- open project in Android Studio
- go to pubspec.yaml and run Pub get
- connect your choice of phone or emulator
  - ensure developer options are enabled on the phone
  - check SDK manager to install appropriate platforms/tools
  - ios devices need to be registered with xcode for testing
- build app
  - for ios a prompt will appear to use Runner.xcodeproject
