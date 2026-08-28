<<<<<<< HEAD

# 🌿 PlantPal AI

> **An AI-powered plant identification and care assistant built with Flutter.**

PlantPal AI is a cross-platform Flutter application that helps users identify plants from images and provides useful plant-care information using Artificial Intelligence.

The application allows users to scan or upload a plant image, analyze it using AI, view detailed plant information, save plants to history or favorites, create watering reminders, and generate plant reports.

---

## ✨ Features

### 🌱 AI Plant Identification

* Capture a plant image using the camera.
* Select a plant image from the gallery.
* Analyze the image using AI.
* Identify the plant and display relevant information.

### 🔍 Plant Analysis

PlantPal AI provides information such as:

* Plant name
* Plant description
* Plant characteristics
* Care information
* Watering requirements
* Sunlight requirements
* Additional plant-care recommendations

### ❤️ Favorites

Users can save plants they are interested in to their favorites for quick access later.

### 📚 Scan History

Previously analyzed plants can be stored locally and viewed again from the history section.

### 🔔 Watering Reminders

Users can create watering reminders for their plants.

Reminders support:

* Custom reminder time
* Specific days of the week
* Enable/disable reminder
* Delete reminder

### 📄 PDF Reports

Users can generate a PDF report containing information about an analyzed plant.

### 📱 Responsive UI

The application is designed to work across different screen sizes, including:

* Android phones
* Tablets
* Desktop screens

The UI adapts its layout according to the available screen size.

### 🔄 Orientation Control

* Splash screen is locked to portrait orientation.
* Onboarding screen is locked to portrait orientation.
* Normal application screens support device rotation.

---

## 🧠 AI Integration

PlantPal AI uses **Google Gemini 2.5 Flash** to analyze plant images and generate plant-related information.

### AI Analysis Flow

```text
User
  │
  ▼
Capture / Select Plant Image
  │
  ▼
Send Image to Gemini 2.5 Flash
  │
  ▼
AI Image Analysis
  │
  ▼
Plant Identification
  │
  ▼
Plant Care Information
  │
  ▼
Structured Result
  │
  ▼
Result Screen
```

Gemini 2.5 Flash is used to process the uploaded plant image and generate relevant information such as:

* Plant name
* Plant description
* Plant characteristics
* Watering requirements
* Sunlight requirements
* Care recommendations
* Other useful plant-care information

The generated information is then parsed and displayed through the Flutter application's result interface.


## 🏗️ Architecture

PlantPal AI follows a feature-based architecture with separation of responsibilities.

```text
lib/
│
├── app/
│   ├── bindings/
│   ├── routes/
│   └── theme/
│
├── core/
│   ├── responsive/
│   ├── services/
│   └── ...
│
├── features/
│   ├── splash/
│   ├── onboarding/
│   ├── navigation/
│   ├── home/
│   ├── scan/
│   ├── analysis/
│   ├── result/
│   ├── history/
│   ├── favorites/
│   ├── reminder/
│   └── settings/
│
└── shared/
    ├── widgets/
    └── ...
```

### Design Approach

The project uses:

* Feature-based organization
* GetX for state management and navigation
* Controller-based business logic
* Repository pattern for data handling
* Reusable widgets
* Responsive UI utilities

---

## 🛠️ Technology Stack

| Technology              | Purpose                                |
| ----------------------- | -------------------------------------- |
| Flutter                 | Cross-platform application development |
| Dart                    | Programming language                   |
| GetX                    | State management and navigation        |
| Google Gemini 2.5 Flash | AI-powered plant image analysis        |
| Hive                    | Local data persistence                 |
| Local Notifications     | Plant watering reminders               |
| PDF                     | Plant report generation                |
| Git & GitHub            | Version control                        |

---

## 🚀 Application Flow

```text
Splash Screen
      ↓
Onboarding
      ↓
Home
      ↓
Scan Plant
      ↓
Select / Capture Image
      ↓
AI Analysis
      ↓
Plant Result
      ├── Add to Favorites
      ├── Create Reminder
      └── Generate PDF
      ↓
History / Favorites
```

---

## ⚙️ Getting Started

### Prerequisites

Make sure the following are installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android Emulator or physical Android device
* Git

Check your Flutter installation:

```bash
flutter doctor
```

---

### Clone the Repository

```bash
git clone https://github.com/shaw2002-dev/PlantPal-AI.git
```

Move into the project:

```bash
cd PlantPal-AI
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## 🔐 Configuration

Some services used by the application may require API credentials or additional configuration.

**Do not commit API keys, passwords, private credentials, or `.env` files to the repository.**

For local development, configure required credentials according to the project's environment configuration.

---

## 🧪 Testing

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

---

## 📸 Screenshots

Add screenshots of the main application screens here.

Recommended screenshots:

1. Splash Screen
2. Onboarding
3. Home Screen
4. Scan Screen
5. AI Analysis
6. Plant Result
7. History
8. Favorites
9. Reminder
10. PDF Report

Example:

```text
docs/screenshots/
├── splash.png
├── onboarding.png
├── home.png
├── scan.png
├── result.png
├── history.png
├── favorites.png
└── reminder.png
```

---

## 🎯 Project Objectives

The main objectives of PlantPal AI are:

* Make plant identification easier using AI.
* Provide accessible plant-care information.
* Allow users to maintain a history of analyzed plants.
* Help users remember plant watering schedules.
* Provide a simple and responsive user experience.
* Demonstrate practical implementation of AI within a Flutter application.

---

## 🔮 Future Improvements

Potential future enhancements include:

* Plant disease detection
* Weather-based plant-care recommendations
* Multi-language support
* Plant growth tracking
* Plant health scoring
* Cloud synchronization
* User accounts and personalized plant collections

---

## 👨‍💻 Project

**PlantPal AI**

Built with **Flutter & Artificial Intelligence**.

GitHub Repository:

https://github.com/shaw2002-dev/PlantPal-AI
=======
# 🌿 PlantPal AI

> **An AI-powered plant identification and care assistant built with Flutter.**

PlantPal AI is a cross-platform Flutter application that helps users identify plants from images and provides useful plant-care information using Artificial Intelligence.

The application allows users to scan or upload a plant image, analyze it using AI, view detailed plant information, save plants to history or favorites, create watering reminders, and generate plant reports.

---

## ✨ Features

### 🌱 AI Plant Identification

* Capture a plant image using the camera.
* Select a plant image from the gallery.
* Analyze the image using AI.
* Identify the plant and display relevant information.

### 🔍 Plant Analysis

PlantPal AI provides information such as:

* Plant name
* Plant description
* Plant characteristics
* Care information
* Watering requirements
* Sunlight requirements
* Additional plant-care recommendations

### ❤️ Favorites

Users can save plants they are interested in to their favorites for quick access later.

### 📚 Scan History

Previously analyzed plants can be stored locally and viewed again from the history section.

### 🔔 Watering Reminders

Users can create watering reminders for their plants.

Reminders support:

* Custom reminder time
* Specific days of the week
* Enable/disable reminder
* Delete reminder

### 📄 PDF Reports

Users can generate a PDF report containing information about an analyzed plant.

### 📱 Responsive UI

The application is designed to work across different screen sizes, including:

* Android phones
* Tablets
* Desktop screens

The UI adapts its layout according to the available screen size.

### 🔄 Orientation Control

* Splash screen is locked to portrait orientation.
* Onboarding screen is locked to portrait orientation.
* Normal application screens support device rotation.

---

## 🧠 AI Integration

PlantPal AI uses Artificial Intelligence to analyze plant images and generate plant-related information.

### Analysis Flow

```text
User
  │
  ▼
Capture / Select Image
  │
  ▼
Image Processing
  │
  ▼
AI Analysis
  │
  ▼
Plant Identification
  │
  ▼
Plant Care Information
  │
  ▼
Result Screen
```

The AI-generated result is then displayed in a structured format inside the Flutter application.

---

## 🏗️ Architecture

PlantPal AI follows a feature-based architecture with separation of responsibilities.

```text
lib/
│
├── app/
│   ├── bindings/
│   ├── routes/
│   └── theme/
│
├── core/
│   ├── responsive/
│   ├── services/
│   └── ...
│
├── features/
│   ├── splash/
│   ├── onboarding/
│   ├── navigation/
│   ├── home/
│   ├── scan/
│   ├── analysis/
│   ├── result/
│   ├── history/
│   ├── favorites/
│   ├── reminder/
│   └── settings/
│
└── shared/
    ├── widgets/
    └── ...
```

### Design Approach

The project uses:

* Feature-based organization
* GetX for state management and navigation
* Controller-based business logic
* Repository pattern for data handling
* Reusable widgets
* Responsive UI utilities

---

## 🛠️ Technology Stack

| Technology          | Purpose                                         |
| ------------------- | ----------------------------------------------- |
| Flutter             | Cross-platform application development          |
| Dart                | Programming language                            |
| GetX                | State management and navigation                 |
| Gemini / AI         | Plant image analysis and information generation |
| Hive                | Local data persistence                          |
| Local Notifications | Plant watering reminders                        |
| PDF                 | Plant report generation                         |
| Git & GitHub        | Version control                                 |

---

## 🚀 Application Flow

```text
Splash Screen
      ↓
Onboarding
      ↓
Home
      ↓
Scan Plant
      ↓
Select / Capture Image
      ↓
AI Analysis
      ↓
Plant Result
      ├── Add to Favorites
      ├── Create Reminder
      └── Generate PDF
      ↓
History / Favorites
```

---

## ⚙️ Getting Started

### Prerequisites

Make sure the following are installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android Emulator or physical Android device
* Git

Check your Flutter installation:

```bash
flutter doctor
```

---

### Clone the Repository

```bash
git clone https://github.com/shaw2002-dev/PlantPal-AI.git
```

Move into the project:

```bash
cd PlantPal-AI
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## 🔐 Configuration

Some services used by the application may require API credentials or additional configuration.

**Do not commit API keys, passwords, private credentials, or `.env` files to the repository.**

For local development, configure required credentials according to the project's environment configuration.

---

## 🧪 Testing

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

---

## 📸 Screenshots

Add screenshots of the main application screens here.

Recommended screenshots:

1. Splash Screen
2. Onboarding
3. Home Screen
4. Scan Screen
5. AI Analysis
6. Plant Result
7. History
8. Favorites
9. Reminder
10. PDF Report

Example:

```text
docs/screenshots/
├── splash.png
├── onboarding.png
├── home.png
├── scan.png
├── result.png
├── history.png
├── favorites.png
└── reminder.png
```

---

## 🎯 Project Objectives

The main objectives of PlantPal AI are:

* Make plant identification easier using AI.
* Provide accessible plant-care information.
* Allow users to maintain a history of analyzed plants.
* Help users remember plant watering schedules.
* Provide a simple and responsive user experience.
* Demonstrate practical implementation of AI within a Flutter application.

---

## 🔮 Future Improvements

Potential future enhancements include:

* Plant disease detection
* Weather-based plant-care recommendations
* Multi-language support
* Plant growth tracking
* Plant health scoring
* Cloud synchronization
* User accounts and personalized plant collections

---

## 👨‍💻 Project

**PlantPal AI**

Built with **Flutter & Artificial Intelligence**.

GitHub Repository:

https://github.com/shaw2002-dev/PlantPal-AI

>>>>>>> 298ae04001954f7f2a097ee04a60317427f4f8c9
