# 📌Taskly Firebase App

Taskly is a simple task management app built using Flutter and Firebase Firestore as the backend. This app performs CRUD (Create, Read, Update, Delete) operations, allowing users to add, view, update, and delete tasks in real-time.

## ✨Features:

- Add new tasks with ease.
- View all added tasks in real-time from Firestore.
- Update existing tasks seamlessly.
- Delete tasks when they are no longer needed.
- Fully integrated with Firebase Firestore for real-time data synchronization.

## 📱Technologies Used:

- **Flutter**: UI framework for building cross-platform applications.
- **Firebase Firestore**: Cloud NoSQL database for real-time data storage.

## 📂Installation & Setup:

1. **Clone the repository**

   ```bash
   git clone https://github.com/PAIshanMadusha/taskly-firebase-app.git
   cd taskly-firebase-app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up Firebase**

## 🔥Struggling to Connect Firebase to Flutter?

- 📖I’ve written a detailed [Medium](https://medium.com/@ishanmadusha) article explaining the step-by-step process to connect Firebase to Flutter with screenshots.

- 📖**Read my blog on Medium here:** [Link](https://medium.com/@ishanmadusha/how-to-connect-firebase-manually-to-a-flutter-android-project-without-errors-7a2c2a8e2741)

### To use Firebase services in this project, follow these steps:

   **Step 1: Create a Firebase Project**

   - Go to [Firebase Console](https://console.firebase.google.com/).
   - Click on **Add Project** and enter a project name.
   - Follow the setup instructions and create the project.

   **Step 2: Add Firebase to Your Flutter App**

   - In the Firebase console, click **Project Settings**.
   - Scroll down and find **Your Apps** section.
   - Click on **Add App** and select **Android** or **iOS**, depending on your target platform.
   - Enter the **package name** (found in `\android\app\build.gradle.kts` namespace = "[Android package name]" for Android or `\ios\Runner.xcodeproj\project.pbxproj` PRODUCT_BUNDLE_IDENTIFIER = "[Apple bundle ID]" for iOS).
   - Follow the instructions and download the necessary configuration files.

   **Step 3: Configure Firebase Files**

   - For **Android**:
     - Download `google-services.json` from Firebase.
     - Move it to `android/app/`.
     
   - For **iOS**:
     - Download `GoogleService-Info.plist` from Firebase.
     - Move it to `ios/Runner/`.

   **Step 4: Enable Firestore**

   - In Firebase Console, go to **Build > Firestore Database**.
   - Click **Create Database** and select test mode (for development).
   - Set up Firestore rules to allow read/write access (modify for production later).

5. **Run the app**

   ```bash
   flutter run
   ```

## 📸System Screenshots:
---
<p align="center">
  <img src="https://github.com/user-attachments/assets/69b37eec-d3e4-4c5c-8885-f8acbbfd0d04" alt="Screenshot 1" width="196">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/fdd555e0-9e3f-4af6-873a-5bd3c6ee2d68" alt="Screenshot 2" width="196">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/2fcee700-ac59-4b02-85f7-c157a437b11f" alt="Screenshot 3" width="196">
</p>

## 🚀Contributing:

Feel free to contribute by opening an issue or submitting a pull request!

## 📜License:

This project is licensed under the MIT License.

---

Made with ❤️ by [Ishan](https://github.com/PAIshanMadusha).
