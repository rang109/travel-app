# Travel App 
[Description](#description) ● [Features](#features) ● [Setup](#setup) ● [Contributing](#contributing) ● [Acknowledgement](#acknowledgement) ● [Contact](#contact)

## 💡Description
<!--to add pa soon mwehhe-->

## ✨️Features
<!-- to be finalized -->

## 🤝Contributing
**How to contribute:**
<details>
  <summary><strong style="font-size: 50px;">For Team Members:</strong></summary>
<br>
  
  1. Clone the repository:
  ```bash
  git clone https://github.com/your-username/travel-app.git
  cd travel-app
  ```
  2. Create a new branch for every new feature:
     - everything needed for a specific feature will be worked on the created branch para mas dali ang pag-fix sa bugs and adding something more for that specific feature
     - you may create a sub branch for your own assigned task (e.g. API, Frontend, etc.):
       - repeat steps 3 and 4
       - create a pull request from the sub branch to the feature branch
       - don't forget to add clear descriptions of the changes when creating a pull request
  ```bash
  git checkout -b feature-name
  ```
  3. ❗️Commit all your changes:
     - make sure to commit and add a comment of the changes para dali ang pag track sa nabuhat
  ```bash
  git add .
  git commit -m "Add comment on changes being made"
  ```
  4. Push your changes to the specific branch:
  ```bash
  git push origin feature-name
  ```
  5. Create a Pull Request (PR):
     - After pushing, go to GitHub and create a pull request from your feature branch to the main branch.
     - Ensure your PR title and description are clear about the changes.
    
  [back to top](#travel-app)
  
</details>

**Guidelines**
<details>
  <summary><strong style="font-size: 50px;">For Frontend Members:</strong></summary>
<br>
  
  1. For organization purposes, please store your `.dart` files on the following folders:
     - `pages` for pages (Home Page, Locations Pages, Itinerary Pages, etc.)
     - `widgets` for widgets and components (button templates, text field templates, timetable, etc.)
     - `services` for functions and classes that directly communicate with the backend
  2. It is also highly encourage to store your `.dart` files on more specified folders depending on its assigned feature
     - `auth` for `.dart` files used for Auth
     - `home` for Home
     - `locations` for Locations
     - `itinerary` for Itinerary
  3. For widgets, if you think a widget can be generally used on any page (doesn't matter if it's an auth page, home page, etc.),
     please store them at the `generic` folder
  4. Colors and font classes are already defined for you in `colors.dart` and `text_styles.dart` respectively under the `config` folder. Please refer
     to these custom colors and font styles to ensure consistency with the Figma design
  5. For more inquiries, please relay those to the #frontend Discord channel 
    
  [back to top](#travel-app)
  
</details>
