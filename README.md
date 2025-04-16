# Project App

A Flutter web application that displays a list of software projects using data from a remote JSON API.
This is just a final exam for the Flutter course at Catania's Steve Jobs Academy ITS. Nothing fancy, just a way to test our knowledge.

## 🔍 Overview

The app shows:

- A list of projects with name and image
- A detail view with full description and favorite toggle
- Ability to delete a project (non-persistent)
- Local management of favorite status

Data is fetched from a mock API hosted at:  
`https://my-json-server.typicode.com/zoelounge/menupizza/projects`

## 🛠️ Built With

- [Flutter](https://flutter.dev/) 3.32 (Web)
- Dart 3.8 (Beta)
- `http` package for API requests

## 🧪 Features

- Responsive layout (Web only)
- Interactive cards with Material icons
- Favorite status stored locally (non-persistent)
- Error handling for image loading (necessary to  fix image URLs that can't be rendered in Flutter Web due to CORS restrictions)

## 🚀 Build & Deploy

To build the web version:

```bash
flutter build web
```

To deploy to GitHub Pages:

```bash
git subtree push --prefix build/web origin gh-pages
```

## 📦 Author

Made with ❤️ by [jolietnick](https://github.com/jolietnick)
