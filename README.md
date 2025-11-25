# ⚡Harry Potter APP⚡

A mobile Flutter application that allows users to explore the wizarding world of Harry Potter. The app enables searching for characters and magic spells using a clean and intuitive user interface.

## API

This application uses the free HP-API to fetch data. No API key is required

Project created by Beth and maintained by Kostas.
Harry Potter icon by Icons8
© 2025 HP-API. All rights reserved. 

HP-API Link: https://hp-api.onrender.com/

## Features

Character Search: Browse and search for characters by name. View detailed information including house, species, and actor.
Spell Search: Find magic spells by name or description.

### Offline Support (Persistence):

Characters: Data is cached locally using shared_preferences. Once loaded, the character list is available even without an internet connection.
Spells: Requires an active internet connection to fetch data.


## Note on Offline Mode

While character data (names, details) works offline, images are loaded via remote URLs. Therefore, in offline mode, character images will be replaced by placeholder icons.


## Getting Started

### To run this project locally, follow these steps In the compiler console:

### Install dependencies: 
```
flutter pub get
```
### Run the app:
```
flutter run
```

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Supported Platforms

- Android
- iOS

## Demonstartion

### You can find a video presentation and Figma project in the demo/ directory.

### Screenshots:

- #### Home Page

![Home Page](demo\home_page.png)

- #### Character Search Page

![Character Search Page](demo\character_search_page.png)

- #### Character Detail Page

![Character Detail Page](demo\character_detail_page.png)

- #### Magic Spell Search Page

![Magic Spell Search Page](demo\magic_spell_search_page.png)

## Disclaimer

This is an educational project created for university purposes.
All content and data related to the Wizarding World are the property of J.K. Rowling and Warner Bros. Entertainment Inc. This app is not affiliated with or endorsed by the rights holders.