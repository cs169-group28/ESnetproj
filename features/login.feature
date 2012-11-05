Feature: Log in to user account
  As a network administrator 
  So that I can have access to my various networks from different computers 
  I want to be able to log in to my control panel

Background: User information has been added to the database

  Given the following users exist:

  |username       | email            | password      | password_confirmation    |
  | admin         | admin@admin.com  | admin1        | admin1                   |


Scenario: Authenticate using credentials
  When I am on the new user session page
  And I fill in "user_session_username" with "admin"
  And I fill in "user_session_password" with "admin1"
  And I press "login"
  Then I should be on the traceroutes page
  And I should see "Login Successful"

Scenario: Fail to authenticate
  When I am on the new user session page
  And I fill in "user_session_username" with "admin"
  And I fill in "user_session_password" with "admin"
  And I press "login"
  Then I should be on the user session page
  And I should see "Password is not valid"


