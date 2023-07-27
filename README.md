# Blue Saffron School App

![App Demo](app_demo.gif)  <!-- Add a demo gif or image of your app -->

## Description

Blue Saffron School App is a feature-rich mobile application built using Flutter and powered by Firebase services. This app aims to streamline and enhance the communication and management between students, parents, and teachers in Blue Saffron school.

## Features

- **Attendance Tracking:** Keep track of student attendance in real-time.
- **Events & Announcements:** Stay updated with school events and important announcements.
- **Push Notifications:** Get timely alerts and reminders for important events and deadlines.
- **Secure Authentication:** User authentication using Firebase Authentication ensures data security.
- **User Roles:** Differentiate between parents, and teachers for customized access.
- **User Profiles:** Individual profiles for parents, and teachers with relevant details.
- **Cloud Storage:** Securely store and manage files using Firebase Cloud Storage.
- **Data Synchronization:** Realtime synchronization of app data with Firebase Firestore.
- **User-Friendly Interface:** Intuitive and user-friendly UI/UX for a seamless experience.
- **Responsive Design:** Compatible with various devices and screen sizes.
- **Real-time Communication:** Facilitate seamless communication between parents, and teachers by announcement by teachers (to be added)
  <!-- **Exam & Test Results:** Access exam and test results securely.-->

## Screenshots






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
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/9d8ecc55-b4a6-4ff7-acb4-a7d6d2b6f48d" alt="Create" height="450">



### Forgot Password Page

- Allow users to reset their account password if they forget it.
- Utilize Firebase Authentication's password reset functionality for secure password recovery.
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/f6d6ab02-066d-4e1e-9666-fa67c78063a4" alt="Create" height="450">

### Home Page

- Show different icons/buttons based on the user's role (teacher or student).
#### As a teacher
- Teachers can access features like take attendance, create announcement, student's list, messaging,view attendance,add a new student,  etc.
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/ac9adcad-c5e1-4f0b-8f90-479bc9928cdd" alt="Create" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/222c2d88-b6c5-42a1-8975-e334bb0c32da" alt="Create" height="450">
<img src="https://github.com/HarshMakwana27/blue_saffron_school_app/assets/133812075/0535f4c2-57e0-4354-99e8-c3ef97558dae" alt="Create" height="450">





#### As a teacher
- Students can view their attendance, , results, and send messages to teachers.
