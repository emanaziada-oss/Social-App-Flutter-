# Flutter Social Feed App

A simple social application built with **Flutter** and **Firebase Firestore**, featuring real-time posts and comments functionality. The project uses **Cubit** for state management and **Firebase Authentication** for user management.

---

## 📝 Project Description

This app allows users to view a real-time feed of posts and interact by adding comments. It demonstrates a simple social media feed implementation using Flutter and Firebase, with a clean architecture and modern state management.

- **Real-time Posts:** The main feed automatically updates when new posts are added by any user using Firestore's real-time stream.
- **Post Details & Comments:** Clicking on a post navigates to a details screen where users can view and add comments.
- **Authentication:** Users must be authenticated via Firebase Auth to add comments or interact with the feed.
- **State Management:** Cubit (from `flutter_bloc`) is used for handling state efficiently.

---

## 📌 Features

- Real-time feed of posts from Firebase Firestore
- Detailed post view with a list of comments
- Add new comments to a post
- Firebase Authentication for user login/signup
- Cubit state management for clean architecture

---

## 🛠 Technologies Used

- Flutter
- Firebase Firestore
- Firebase Authentication
- Flutter Bloc (Cubit)
- Dart

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed
- Firebase project created and configured
- Dart enabled in your IDE

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/flutter-social-feed.git
cd flutter-social-feed
```
