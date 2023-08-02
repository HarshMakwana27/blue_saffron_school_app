# Blue Saffron School App


<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/826cd8ef-f747-4651-b783-9aab485dd11d" alt="Create" height="200">

## Description

Blue Saffron School App is a feature-rich mobile application built using Flutter and powered by Firebase services. This app aims to streamline and enhance the communication and management between students, parents, and teachers in Blue Saffron school.

## Features
- **User Roles:** Differentiate between parents, and teachers for customized access.
- **User Profiles:** Individual profiles for parents, and teachers with relevant details.
- **User-Friendly Interface:** Intuitive and user-friendly UI/UX for a seamless experience.
- **Attendance Tracking:** Keep track of student attendance in real-time.
- **Events & Announcements:** Stay updated with school events and important announcements.
- **Push Notifications:** Get timely alerts and reminders for important events and deadlines.()
- **Secure Authentication:** User authentication using Firebase Authentication ensures data security.
- **Cloud Storage:** Securely store and manage files using Firebase Cloud Storage.
- **Data Synchronization:** Realtime synchronization of app data with Firebase Firestore.

- **Responsive Design:** Compatible with various devices and screen sizes.
- **Real-time Communication:** Facilitate seamless communication between parents, and teachers by announcement by teachers (to be added)
  <!-- **Exam & Test Results:** Access exam and test results securely.-->


## Pages and Functionality

### Splash Screen
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/ccd42b1e-679c-494b-91e7-05bbb261a2c4" alt="splashscreen" height="450">

### Login Page

- Allow users (parents and teachers) to log in to their respective accounts.
- Utilize Firebase Authentication for secure login.
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/6a37293d-7c4a-4869-bc56-c416cd3dbe78" alt="Login Screen" height="450">

### Signup Page

- Provide options for users to sign up as a parent or a teacher.
- Upon selection, navigate to the respective signup process.
 #### Unique UID and Key Page
- Prompt teachers and students to enter a unique UID and key provided by the school.
- Validate the entered UID and key against a pre-defined list of valid pairs.
-  Once UID and key verification succeed, ask users to provide their email, name, and password for the final account setup.
- Create user accounts with the entered information and link them to the respective roles (teacher or parent) in Firestore.

#### Create account as Parent or Teacher

- Collect user's email, name, and password for parent account creation.
- Store parent/teacher/student-related information in Firestore, linked to the user's account.


  
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/14b0e8b0-9ba5-4a42-8d85-fc5b9aaae89c" alt="role" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/4465cc6b-8cf3-4640-9101-49abaad50932" alt="Create" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/a5549efd-01a9-4c19-b77c-989bc838cb16" alt="Create" height="450">



### Forgot Password Page

- Allow users to reset their account password if they forget it.
- Utilize Firebase Authentication's password reset functionality for secure password recovery.
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/f6d6ab02-066d-4e1e-9666-fa67c78063a4" alt="Create" height="450">

### Home Page

- Show different icons/buttons based on the user's role (teacher or student).
#### As a teacher

- Teachers can access features like take attendance, create announcement, student's list, messaging,view attendance,add a new student,  etc.


<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/4bcdaff3-df38-4dfd-b6a2-3ec8949a727c" alt="Create" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/6659b08b-797c-4286-b865-317b52703d3a" alt="Create" height="450">



<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/837e027a-ccde-4bc2-99ef-a994c76ca948" alt="attlist" height="450">

<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/9d8ecc55-b4a6-4ff7-acb4-a7d6d2b6f48d" alt="Create" height="450">


<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/49dff6f6-5217-44f8-be38-37943b1b450c" alt="picker" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/ff42dce1-07ef-4618-9cca-d2a3aae1da9b" alt="list" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/636dbd3e-f146-4001-96be-4358f37eadcb" alt="attlist" height="450">

<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/b6d17fd3-ef30-4805-96af-aa193532c17c" alt="attlist" height="450">

<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/7fd95b11-8730-42e1-b04c-4793be4bad77" alt="list" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/592c0c7a-1204-4775-90a0-c3b164b5c0bd" alt="list" height="450">




#### As a Parent
- Parent can view their child's attendance, results, and send messages to teachers.
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/085363d1-982b-469d-b58f-2e59ebc5a87c" alt="list" height="450">



<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/a3ca9f4a-0ba4-4ca8-b503-aad825e30666" alt="list" height="450">

<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/4746ab84-caff-49dc-8feb-6549210e1749" alt="list" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/ff42dce1-07ef-4618-9cca-d2a3aae1da9b" alt="list" height="450">

<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/7fd95b11-8730-42e1-b04c-4793be4bad77" alt="list" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/592c0c7a-1204-4775-90a0-c3b164b5c0bd" alt="list" height="450">




## Getting Started(for contributors)

### Prerequisites

- Flutter SDK installed. [Install Flutter](https://flutter.dev/docs/get-started/install)
- Android or iOS emulator/device for testing.

### Installation

1. Clone the repository:

2. Install dependencies: flutter pub get

3. Run the app

## Firebase Configuration

Make sure you have set up your Firebase project and added the necessary configurations in the app. For detailed instructions, refer to official page.

- After that you have to replace your firebase_config file with mine
- And before running app, go to firebase realtime database, and create manually any one uid and key in teachers like this
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/38d40d94-2a57-494c-9e6c-7b6a515bc820" alt="list" height="300">

- now create account with that and after this you will be able to manage keys, in keys section

## Contributing
We welcome contributions to improve the Blue Saffron School App. Feel free to open issues and submit pull requests!

### License
This project is licensed under MIT Licence.

