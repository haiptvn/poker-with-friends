# Poker with Friends

![Screenshot 2024-09-23 at 19 45 33](https://github.com/user-attachments/assets/1962837e-1405-48e1-a83d-b32feee93946)

A DIY Flutter project. I'm building a game client using the Flutter framework and Dart, designed to run on multiple platforms. This client integrates seamlessly with my Go-based poker server, ensuring smooth real-time gameplay and cross-platform compatibility.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/to/state-management-sample).

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/to/resolution-aware-images).

## Progo gen

```
protoc --dart_out=lib/ proto/message.proto
```
