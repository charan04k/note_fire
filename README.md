# Firebase Notes App

## Project Overview

This is a Flutter Notes application developed using **Clean Architecture**, **BLoC** for state management, and **Firebase Authentication** & **Cloud Firestore** as the backend.

### Features

* User Registration
* User Login
* User Logout
* Add Notes
* Edit Notes
* Delete Notes
* View Notes
* Notes are displayed only for the logged-in user
* Clean Architecture
* Dependency Injection using GetIt
* BLoC State Management

---

# Technologies Used

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* flutter_bloc
* get_it

---

# Firebase Configuration

The following Firebase services are enabled:

## 1. Firebase Authentication

Authentication Method:

* Email & Password

Users can register and log in using email and password authentication.

---

## 2. Cloud Firestore

Firestore Database is used to store notes.

### Collection Structure

Collection: **notes**

Document Fields

```
userId
title
description
createdAt
updatedAt
```

Each note belongs to the authenticated user using the `userId` field.

---

## 3. Firestore Security Rules

The Firestore rules allow authenticated users to access only their own notes.

Example:

```
match /notes/{noteId} {
  allow read, write: if request.auth != null &&
      request.auth.uid == resource.data.userId;
}
```

---

## 4. Firebase Configuration Files

The following Firebase configuration files are required.

### Android

```
android/app/google-services.json
```

### iOS

```
ios/Runner/GoogleService-Info.plist
```

These files should be downloaded from the Firebase Console and placed in the respective directories.

---

# How to Run the Project

## 1. Clone the project

```
git clone <repository_url>
```

or download the ZIP.

---

## 2. Open the project

Open the project in

* Android Studio
* VS Code

---

## 3. Install dependencies

```
flutter pub get
```

---

## 4. Configure Firebase

If the Firebase configuration files are not included:

### Android

Copy

```
google-services.json
```

to

```
android/app/
```

### iOS

Copy

```
GoogleService-Info.plist
```

to

```
ios/Runner/
```

---

## 5. Generate Firebase configuration (if required)

```
flutterfire configure
```

This generates:

```
firebase_options.dart
```

---

## 6. Run the application

```
flutter run
```

---

# Project Architecture

```
lib
│
├── core
│
├── features
│   ├── auth
│   │   ├── data
│   │   ├── domain
│   │   └── presentation
│   │
│   └── notes
│       ├── data
│       ├── domain
│       └── presentation
│
├── injection_container.dart
│
└── main.dart
```

---

# Clean Architecture Layers

### Presentation

* Screens
* Widgets
* BLoC

### Domain

* Entities
* Repository Interfaces
* Use Cases

### Data

* Models
* Repository Implementations
* Remote Data Sources
* Firebase Integration

---

# Application Flow

```
UI
   ↓
Bloc
   ↓
UseCase
   ↓
Repository (Interface)
   ↓
Repository Implementation
   ↓
Remote Data Source
   ↓
Firebase Authentication / Firestore
```

---

# Notes

* Users can access only their own notes.
* Notes are automatically filtered based on the authenticated user's UID.
* Firestore stores timestamps for note creation and updates.
* Dependency Injection is implemented using GetIt.
* State management is implemented using flutter_bloc.
