# ikmal-azman-iOS
Take Home Project - Scalio

## App Demo
<img src="https://user-images.githubusercontent.com/59039044/181412077-a7923b62-8752-49b4-9138-ccb8292a5d20.mov" width="200">

## App Screenshots

| Search | Results | 
| ---- | ------ |  
|<img src="https://user-images.githubusercontent.com/59039044/181413002-2cb53de1-2b83-4a60-89f9-21710ba5fb1f.png" width="200">| <img src="https://user-images.githubusercontent.com/59039044/181413057-a4287084-3546-43e7-9a40-383f71f2b161.png" width="200"> |

![Simulator Screen Shot - iPhone 12 Pro - 2022-07-28 at 11 14 44]()

## App Flow
<img src="https://user-images.githubusercontent.com/59039044/181412580-df6aa936-68d7-4bb1-b56a-586854e73299.png" width="600">

## Test Coverage
<img src="https://user-images.githubusercontent.com/59039044/181414909-b930218f-9809-4eb2-92ab-18c6c167cb93.png" width="700">


## Overview

The goal is to create a simple iOS application which makes a request to an API, parses the response, and displays the result in the UI. The app will consist of **two major components** - one **search** component and one **results** component. 

## Detail

### Search Component

This component should contain two elements:

- 'Login' TextView input for entering a String value
- 'Submit' Button for initiating a request to 
`https://api.github.com/search/users?q={login} in:login`, where {login} is the input value

```bash
# Example curl GET request to search for for login `foo`
curl --request GET '[https://api.github.com/search/users?q=foo in:login](https://api.github.com/search/users?q=foo%20in:login)'
```

### Results Component

This component should contain a single element:

- Results view for displaying the results of the User search

The results view has the following requirements:

- Display three columns from the response:
    - `avatar_url`
    - `login`
    - `type`
- Use [Pagination](https://docs.github.com/en/rest/guides/traversing-with-pagination#basics-of-pagination), with **9** items displayed Per_Page
- The `login` column being should be sorted alphabetically by default

## UI

The user interface should appear modern and simple while following best practices around iOS UI. Creativity is encouraged, so feel free design the UI in any way you wish. However, the app must be functionally complete. 

## Use-Case

- After the app is launched, the **Search** component is displayed
- The user enters a random String value into to the 'Login' field and clicks the 'Submit' button
- The app sends a http request to `https://api.github.com/search/users?q={login} in:login`, where {login} is the String value entered by the user
- The app then parses the response from the server. If data is returned, the **Results** component should display the fetched values. If there is an issue with the request, then an error message should be displayed.

## Requirements

- The app has to compile and run without issue. It should be stable and reasonably fool-proof, handling all obvious test cases.
- The app should contain basic tests, with  >50% code coverage.

## Suggestions

- MVVM Architecture
- RxSwift
- Moya for network requests

## Deliverables

- The final deliverable should be a fully-functioning iOS project that compiles and runs without issue.
- Your code repository should be named `{firstName}-{lastName}-ios`.
- A **private** GitHub repository is the preferred delivery method for code. Please invite the following GitHub users to allow access:
    - dsuvorov
    - micahjlucas
- Please include your **GitHub repository** link in your email reply to HR.
