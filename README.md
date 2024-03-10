# 🍏 The Movie Database - iOS
The Movie Database is my implementation of required technical task for Tinybeans.

## Description
This is my implementation for the task requested by Tinybeans company. An iOS app to fetch and present popular movies and their details from TMDB website.

## Getting started
To run the project, you simply open the project and wait for packages to be downloaded

## Tech stack
- Swift and SwiftUI for the design.
- SPM for handling packages.
- Used MVVM UI Design Pattern applying Clean Architecture principles (Interactor/UserCase, Repository, Layers). For more info, <a href="https://www.google.com](https://inoor.hashnode.dev/clean-mvp-with-swift">click here</a> to view my article about applying Clean Architecrture principles to any UI Design Pattern.
- Core Data for database caching.

## Main Features
- List the popular movies for the user to browse them.
- Custom SwiftUI views for common usage.
- Detailed cell to show the lead image, headline, and the type of the article.
- Detailed view for the user to show the details of the desired movie.
- MVVM architecture with Clean Architecture principles and Single Responsibility everywhere!
- Error handling for network and fetching errors.

### Bonus features:
- Pagination for loading movies.
- Implemented In-Memory caching for images to enhance UX.
- Implemented database caching using Core Data stack built from scratch.
- Mocking for the network and database layers.
- Unit testing for the main layers (Network & Database) using Mocks.

## Packages
- Alamofire: Used for all of the heavy work of networking in the app.

## Project status
The project is completed in what was mentioned in the requirements document. 
However, due to time constraint, it could have been done with more Unit & Integration testing and more detailed error handling.

## Project Branches
I used the "develop" branch all the time to develop the features and then made PRs from each sub-branch after I complete a milestone to be merged to the develop branch and finally to the main branch.
