# Project Marian
A small project for showing system architecture. To show to-do list with a pin code lock.

## Features
PIN Code: a 6-digit PIN allows a user to lock access to the main feature. Currently, it is hardcoded to '123456'
Task List: with 3 status tabs, pagination loading grouping by create date and swipe to delete on each task

## Design
Figma: [link](https://www.figma.com/file/YK9yaujyNTIYSDRiiIDqf3/Marian?type=design&node-id=0%3A1&mode=design&t=jmOknPO1b64pf51n-1)
Adapting design system to use in the project with hierarchy color (e.g. `text.main` for the color of main text) Typography adapting from Material design with 3 main categories (title, body, and caption).

## Coding Structure
Using Clean architecture, 3 layers of data, domain, and presentation. Removing use cases to remove complexity.
State management uses Cubit to reduce complexity as well.

*Data Store* class to handle API calls or local storage with abstract class. Should be used Either to pass success or failure cases.

*DTO* class for mapping function from API model to main model.

*Repository* class to handle the type of data that will be used in each feature. This will be called data store to get the data.

*Entity* class to store main model use across the project.

*Page* class for UI.

*Cubit* class for business logic on each page. Only need 1 for each page. Using behavior to store the current state of the page.

*State* class for display model and state model used for each page.

### Libraries Used
- shimmer: for modernized loading UI.
- custom_sliding_segmented_control: for easy customized segmented control.
- flutter_svg: for SVG reader and widget render.
- infinite_scroll_pagination: for handling pagination scroll.
- collection: a utility lib for grouping lists to map (not necessary).
- fpdart: a functional programming lib for use to send models with fail conditions.
- dio: network adapter lib, easy to handle error cases, and more.
- intl: a utility lib, for using date formatter.
- shared_preferences: for local storage helper.
- flutter_launcher_icons: for app icon applying.

## Check List
- Null-safe unit test to fix mocking class issue
- Handle localized strings for multi-language and maintainability.
- Generated asset class to avoid human error in applying image.
- More flexible design token.
- Generated design token.
- UI Test.
- Enhance API error handling.
- Base model for page, cubit, state, and API.
- Import group.
- iOS certificate
- Base url
