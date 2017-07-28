# URLockBox

URLockBox is a Rails app that allows users to create and store links!

This app is built with a restful API based on the resource 'link' (with the exception of /links, which is replaced by the root).

## Using the App

URLockBox can be viewed live at https://loliveri-urlockbox.herokuapp.com/.

Users must sign up or log in with an existing account to continue:

<img width="1182" alt="screen shot 2017-07-27 at 6 19 34 pm" src="https://user-images.githubusercontent.com/4068853/28697543-eac21dee-72f9-11e7-8375-901b73911912.png">

Once logged in, users can review their already saved links and add new ones. Note that URLs must be valid to be submitted, and need to also include a title.

<img width="1166" alt="screen shot 2017-07-27 at 6 22 25 pm" src="https://user-images.githubusercontent.com/4068853/28697545-ef5e9fa8-72f9-11e7-947c-a6e59f8b8749.png">

Users edit their link urls and titles, and can also mark their reads as "read" or "unread". 

<img width="1199" alt="screen shot 2017-07-27 at 6 23 26 pm" src="https://user-images.githubusercontent.com/4068853/28697549-f3609318-72f9-11e7-8f21-9045b3e61fff.png">

Users can also filter their links by those that are read, unread, or just search by the text in either the link or the title! Users can also easily clear their search with the "clear filters" button.

<img width="1204" alt="screen shot 2017-07-27 at 6 27 43 pm" src="https://user-images.githubusercontent.com/4068853/28697551-f50aa618-72f9-11e7-80b6-4ccd301a506f.png">

Links marked as 'Top' (most visited of all users) or 'Spicy' (in top 10 of all visited sites) are dependent on data from a companion app, https://github.com/lao9/hot-reads, retrieved and compared through a service utilizing Faraday.

<img width="1204" alt="screen shot 2017-07-27 at 6 28 24 pm" src="https://user-images.githubusercontent.com/4068853/28697554-f75cdeb8-72f9-11e7-824b-eb45e55b7f03.png">

## Setup

To set up URLockBox:

1. Clone done this repo.
2. Bundle
3. rake db:setup
4. To run the test suite, rspec


## Testing Using Selenium Webdriver

The app has the `selenium-webdriver` gem listed in the `Gemfile` and setup in the `rails_helper.rb`. You will need to download version 46 of Firefox [here](https://www.softexia.com/windows/web-browsers/firefox-46). If you do have it, make sure it is on version 46. Selenium does not work with all versions of Firefox, so make sure that you are using Firefox 46 or else it will potentially cause you problems.

If you already have Firefox and it's on a version more recent than 46, the easiest way to downgrade is to turn off automatic updates, uninstall Firefox, and then install version 46.
    
You can then write capybara feature tests and add `js: true` tag if you'd like your test to use the Selenium WebDriver rather than the default WebDriver.  Your tests will execute and recognize your JavaScript.

If you're having problems troubleshooting asynchronous actions (like DOM changes after an AJAX request), [peruse this section of Capybara's docs](https://github.com/teamcapybara/capybara#asynchronous-javascript-ajax-and-friends)

It is highly suggested that you also check out the Capybara docs and and the section on [selenium-webdriver](https://github.com/teamcapybara/capybara#selenium).

## Companion

URLockbox's companion app is live at https://loliveri-hotreads.herokuapp.com/. Hot Reads tracks which links are most popular for the past 24 hours.
