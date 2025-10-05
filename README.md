[![Flutter CI](https://github.com/IsaiChristian/blackBullTest/actions/workflows/main.yml/badge.svg)](https://github.com/IsaiChristian/blackBullTest/actions/workflows/main.yml)

[Coverage Result](https://isaichristian.github.io/blackBullTest/index.html)

# BlackBull MovieDB

A Flutter test for Christian Isai.

## Preface

Hi I'm Christian Isai thanks for your consideration for the position. 
Somethings to considere while reviewing this test. I took the opportunitie 
to try some of the latest futures including some experimental. 

Other things that I decided to practice while doing your test was:
- Setting a worker in my own VPS to run the github Actions (You can click on the little badge on top to see the each run!)
- Using github actions to perform an analysis for flutter test, (I also printed the results with LCOV)

I also took tried to make the app pop visually and decided it to brand it with BlackBull. I hope it looks good to you too!

![blocking_error](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/blocking_error.jpg)
### Screenshots and video 
![favorites_empty](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/favorites_empty.jpg)
![favorites_filled](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/favorites_filled.jpg)

![home](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home.jpg)
![home_loading_init](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home_loading_init.jpg)
![home_loading_more](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home_loading_more.jpg)
![home_not_blocking_error](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home_not_blocking_error.jpg)
![movie_detail](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/movie_detail.jpg)

![search](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/search.jpg)
![search_active](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/search_active.jpg)
![search_query_error](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/search_query_error.jpg)

![working_video.mp4](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/working_video.mp4)

## Getting Started

After cloning the repository the first thing you'll need is to create your .env file inside secrets with a valid [Themoviedb](https://www.themoviedb.org/)

in this project we are using --enable-experiment=dot-shorthands for you to be able to run / build you'll have to add that parameter to your run like this

`` flutter run --enable-experiment=dot-shorthands ``

We are using a Clean Code Arquitecture with BloC as the state management

Folder Structure is as follows
```plaintext
lib
├── core <----------------------------- Here we put everything shared across the app
|   ├── di <--------------------------- Dependendy injection
|   ├── error <------------------------ Error and failures related (here we have the logger service and a error bus) 
|   ├── network <---------------------- Network Related
|   ├── router 
|   └── services <--------------------- Local services
├── data <----------------------------- This layer is where data gathered
│   ├── mappers <---------------------- Quick transformations so we can move across layers easier
│   ├── models  <---------------------- Models from DataSources, usually mirror the JSON  
│   └── repositories <----------------- Implemantation
├── domain <--------------------------- This Layer is were we pass the prepare the info for the view
│   ├── entities <--------------------- This usually mirror the info shown in the UI
│   └── repositories <----------------- Abstractions here
├── presentation <--------------------- Shared widgets 
└── src <------------------------------ Convention below we each feature
    ├── app <-------------------------- The only bloc with no page attached, used to control events that happen across the app (Auth / network / )
    ├── favorites\presentation
    ├── home\presentation 
    |   ├── bloc <--------------------- State management
    |   ├── pages <-------------------- For when the feature uses a whole page
    |   └── widgets <------------------ For reusable widgets (Like favorite button)
    ├── movie_detail\presentation
    ├── search\presentation
    └── main.dart <-------------------- Everything starts Here.
```
note: Test Folder Structure should mirror Lib.


