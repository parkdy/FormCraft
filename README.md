# FormCraft

FormCraft is a web application that lets you build and publish custom online forms. It features a Form Editor in which you can drag and drop fields to build a form. Once you save it to the database, you can share a link to the form so others can visit and submit it. The app has user authentication and permissions, email notifications, and form results that can be downloaded in CSV and Excel file formats.

The backend is built in Ruby on Rails, whereas the Form Editor is a single page Backbone.js app. Testing was done in RSpec and the application was deployed through Heroku.

## Getting Started

### Development

1. Clone Git repository or download as ZIP.
2. Navigate to `FormCraft` directory in terminal.
3. Install required gems by entering:
    - `bundle install`
4. Create `config/database.yml` file to configure database.
5. Create, migrate, and seed database by entering:
    - `rake db:setup`
7. Start server by entering:
    - `rails server`
4. Open browser window and enter:
    - `localhost:3000`

### Production

1. Create `config/application.yml` file to configure secret keys:
    - SECRET_TOKEN (run `rake secret` to generate)