
# Carefinder Flutter Client

Client built using Flutter built around my Carefinder Spring Boot Application


## Todo

- [x] Implement new API
- [ ] Add Authentication -- Login and Register
- [ ] Add create/edit hospitals for admin users
- [ ] Clean up code
- [x] Write code

## Environment Variables

To run this project, you will need to add the following environment variables

`API_URL` - URL to API resource



## Run Locally

*This is is a flutter project, make sure you have installed and setup [flutter](https://docs.flutter.dev/get-started/install)*

Clone the project

```bash
  git clone https://github.com/nahoczki/carefinder-flutter.git
```

Go to the project directory

```bash
  cd carefinder-flutter
```

Install dependencies

```bash
  flutter pub get
```

Run app

```bash
  flutter run
```

(Please follow flutter's official documentation to run properly depending on device)


## FAQ

#### Why isnt the map showing up on the app?

Retrieve a google maps sdk key and replace placeholders found throughout the "Get Started" section [here](https://pub.dev/packages/google_maps_flutter)


