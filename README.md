# URLockBox

URLockBox is a Rails app that allows users to create and store links!

![Alt text](/Desktop/Screen Shot 2017-07-27 at 6.19.34 PM.png?raw=true "Optional Title")

This app is built with a restful API based on the resource 'link' (with the exception of /links, which is replaced by the root).

Links marked as 'Top' (most visited of all users) or 'Spicy' (in top 10 of all visited sites) are dependent on data from a companion app, https://github.com/lao9/hot-reads, retrieved and compared through a service utilizing Faraday.

## Setup

To set up URLockBox:

1. Clone done this repo.
2. Bundle
3. rake db:setup
4. To run the test suite, rspec

    Note: The app has the `selenium-webdriver` gem listed in the `Gemfile` and setup in the `rails_helper.rb`. You will need to download version 46 of Firefox [here](https://www.softexia.com/windows/web-browsers/firefox-46). If you do have it, make sure it is on version 46. Selenium does not work with all versions of Firefox, so make sure that you are using Firefox 46 or else it will potentially cause you problems.

    If you already have Firefox and it's on a version more recent than 46, the easiest way to downgrade is to turn off automatic updates, uninstall Firefox, and then install version 46.


#### Use

You can then write capybara feature tests and add `js: true` tag if you'd like your test to use the Selenium WebDriver rather than the default WebDriver.  Your tests will execute and recognize your JavaScript.

If you're having problems troubleshooting asynchronous actions (like DOM changes after an AJAX request), [peruse this section of Capybara's docs](https://github.com/teamcapybara/capybara#asynchronous-javascript-ajax-and-friends)

It is highly suggested that you also check out the Capybara docs and and the section on [selenium-webdriver](https://github.com/teamcapybara/capybara#selenium).

## Companion

URLockbox's companion app is live at https://loliveri-hotreads.herokuapp.com/. Hot Reads tracks which links are most popular for the past 24 hours.

## Using the App

Only valid URLs are accepted in URLockbox links. Links are validated using the validate_url gem.

URLockBox can be viewed live at https://loliveri-urlockbox.herokuapp.com/.
