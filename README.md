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
# Screenshots and Video

## Home Screen
| Loading States | Content View | Movie Detail |
|:---:|:---:|:---:|
| ![Initial Loading](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home_loading_init.jpg) | ![Home](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home.jpg) | ![Movie Detail](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/movie_detail.jpg) |
| **Initial Loading** | **Home View** | **Movie Detail** |

| Loading More | Non-Blocking Error |
|:---:|:---:|
| ![Loading More](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home_loading_more.jpg) | ![Error State](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/home_not_blocking_error.jpg) |
| **Loading More Content** | **Non-Blocking Error** |

## Favorites
| Empty State | With Content |
|:---:|:---:|
| ![Empty Favorites](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/favorites_empty.jpg) | ![Filled Favorites](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/favorites_filled.jpg) |
| **Empty Favorites** | **Favorites List** |

## Search
| Default | Active Search | Error State |
|:---:|:---:|:---:|
| ![Search](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/search.jpg) | ![Search Active](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/search_active.jpg) | ![Search Error](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/search_query_error.jpg) |
| **Search Screen** | **Active Search** | **Search Query Error** |

## Error Handling
| Blocking Error |
|:---:|
| ![Blocking Error](https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/blocking_error.jpg) |
| **Blocking Error Screen** |

## Video

https://raw.githubusercontent.com/IsaiChristian/blackBullTest/refs/heads/main/screenshots/working_video.mp4

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

## Technical Decisions 

**Why clean architecture?**
I find it very straight forward once you know what goes where. It also forces to think about each layer and how the information should flow.

**Why Bloc?**
In the same way bloc is also more verbose, but gives a lot more control once everything is setup. 

**Why Dio?**
Dio offers interceptors which are very useful to have just one place to handle everything HTTP related. Having only 1 place for this helps for logging / debugging

**What is the Global error bus?**
Its a way for us to dispatch errors from wherever we want to the AppBloC helping with interacting from outside. 

**How do you error handle?**
We used a functional way of doing it called Either Type 
``
Either<L, R> represents a value that can be one of two possible types:

Left (L) → usually represents a failure or error.

Right (R) → represents a success or valid result.
``

That way you are forced to always aknowledge the Failure or Error path. 

**Is That why the safeCalls?**
Yeah! a little helper to write less and keep the power of this pattern. 

**Why adding a infinite scroll?**
I wanted a different way to show how to handle loading.
They way it works is by keeping check of the scroll position, once we are close enough we call for the next page and append to the list. 


**Is the app prod ready?**
Its close but not really , no production app would have any APIKEY in the code (no matter if we obfuscate or add it on runtime). 
most apps would have AUTH which brings a level of complexity that we are skipping here.



