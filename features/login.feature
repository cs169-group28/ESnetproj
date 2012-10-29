Feature: Log in to user account
  As a network administrator 
  So that I can have access to my various networks from different computers 
  I want to be able to log in to my control panel

Background: User information has been added to the database

  Given the follwing users exist:

  | Username                      | Email          |
  --------------------------------------------------
  | testuser                      | test@user.com  |  
  | testuser2                     | test2@gmail.com|      

  And I am on the PERFSonar login page

Scenario: Authenticate using credentials
  When I fill in the folowing: "Username=>testuser", "Password=>test"
  When I press "Login"
  Then I should be on the "Traceroute page"
  When I press "View profile"
  Then I should be on the "Users page"
  And I should see "testuser"

