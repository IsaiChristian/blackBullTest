[![Flutter CI](https://github.com/IsaiChristian/blackBullTest/actions/workflows/main.yml/badge.svg)](https://github.com/IsaiChristian/blackBullTest/actions/workflows/main.yml)

[Coverage Result](https://isaichristian.github.io/blackBullTest/index.html)

# BlackBull MovieDB

A Flutter test for Christian Isai.

## Preface

Hi, I'm Christian Isai. Thanks for your consideration for the position. 
Something to consider while reviewing this test: I took the opportunity 
to try some of the latest features, including some experimental ones. 

Other things that I decided to practice while doing your test were:
- Setting up a worker on my own VPS to run the GitHub Actions (You can click on the badge at the top to see each run!)
- Using GitHub Actions to perform an analysis for Flutter tests (I also printed the results with LCOV)
- Playing with Animations without the use of lottie or rive.


I also tried to make the app pop visually and decided to brand it with BlackBull. I hope it looks good to you too!

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

After cloning the repository, the first thing you'll need is to create your .env file inside secrets with a valid [Themoviedb](https://www.themoviedb.org/) API key.

In this project, we are using `--enable-experiment=dot-shorthands`. For you to be able to run/build, you'll have to add that parameter to your run like this:

```bash
flutter run --enable-experiment=dot-shorthands
```

We are using Clean Code Architecture with BLoC as the state management solution.

Folder structure is as follows:
```plaintext
lib
├── core <----------------------------- Here we put everything shared across the app
|   ├── di <--------------------------- Dependency injection
|   ├── error <------------------------ Error and failures related (here we have the logger service and an error bus) 
|   ├── network <---------------------- Network related
|   ├── router 
|   └── services <--------------------- Local services
├── data <----------------------------- This layer is where data is gathered
│   ├── mappers <---------------------- Quick transformations so we can move across layers easier
│   ├── models  <---------------------- Models from DataSources, usually mirror the JSON  
│   └── repositories <----------------- Implementation
├── domain <--------------------------- This layer is where we prepare the info for the view
│   ├── entities <--------------------- These usually mirror the info shown in the UI
│   └── repositories <----------------- Abstractions here
├── presentation <--------------------- Shared widgets 
└── src <------------------------------ Convention below: each feature
    ├── app <-------------------------- The only bloc with no page attached, used to control events that happen across the app (Auth/network)
    ├── favorites\presentation
    ├── home\presentation 
    |   ├── bloc <--------------------- State management
    |   ├── pages <-------------------- For when the feature uses a whole page
    |   └── widgets <------------------ For reusable widgets (like favorite button)
    ├── movie_detail\presentation
    ├── search\presentation
    └── main.dart <-------------------- Everything starts here
```
Note: Test folder structure should mirror lib.

## Technical Decisions 

**Why clean architecture?**
I find it very straightforward once you know what goes where. It also forces you to think about each layer and how the information should flow.

**Why BLoC?**
In the same way, BLoC is also more verbose, but it gives you a lot more control once everything is set up. 

**Why Dio?**
Dio offers interceptors, which are very useful for having just one place to handle everything HTTP-related. Having only one place for this helps with logging and debugging.

**What is the global error bus?**
It's a way for us to dispatch errors from wherever we want to the AppBLoC, helping with interactions from outside. 

**How do you handle errors?**
We use a functional approach called the Either type:

`Either<L, R>` represents a value that can be one of two possible types:
- **Left (L)** → usually represents a failure or error
- **Right (R)** → represents a success or valid result

That way, you are forced to always acknowledge the failure or error path. 

**Is that why you have safeCalls?**
Yes! It's a little helper to write less code while keeping the power of this pattern. 

**Why add infinite scroll?**
I wanted a different way to show how to handle loading.
The way it works is by keeping track of the scroll position. Once we are close enough, we call for the next page and append it to the list. 

**Is the app production-ready?**
It's close, but not really. No production app would have any API key in the code (no matter if we obfuscate or add it at runtime). 
Most apps would have authentication, which brings a level of complexity that we are skipping here.