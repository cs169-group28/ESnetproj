Feature: Manage user account
  As a perfSONAR toolkit user
  So that I can personalize my user account
  I want to be able to change my user information

Background: User information has been added to the database

  Given the following users exist:

  |username       | email            | password      | password_confirmation    |
  | admin         | admin@admin.com  | admin1        | admin1                   |
  | admin1        | admin1@admin.com | admin1        | admin1                   |



Scenario: View user information
  	Given I am on the new user session page
  	And I fill in "user_session_username" with "admin"
  	And I fill in "user_session_password" with "admin1"
  	And I press "login"
  	And am on the traceroutes page
	When I follow "view_profile" 
	Then I should be on the users page
	And I should see "admin"
	And I should see "admin@admin.com"
	Then I should not see 'admin1'
	Then I should not see 'admin1@admin.com'

Scenario: Edit user information
	Given I am on the new user session page
  	And I fill in "user_session_username" with "admin"
  	And I fill in "user_session_password" with "admin1"
  	And I press "login"
  	And am on the traceroutes page
	When I follow "view_profile" 
	When I follow 'Edit'
	Then I should see "Edit User"
	And I fill in "user_password" with "new_pass"
	And I fill in "user_password_confirmation" with "new_pass"
	And I press "save"
	Then I should see "User was successfully updated"

Scenario: Fail to edit user information
	Given I am on the new user session page
  	And I fill in "user_session_username" with "admin"
  	And I fill in "user_session_password" with "admin1"
  	And I press "login"
  	And am on the traceroutes page
	When I follow "view_profile" 
	When I follow 'Edit'
	Then I should see "Edit User"
	And I fill in "user_username" with "admin1"
	And I press "save"
	Then I should see "Username has already been taken"

Scenario: Show user
	Given I am on the new user session page
  	And I fill in "user_session_username" with "admin"
  	And I fill in "user_session_password" with "admin1"
  	And I press "login"
  	And am on the traceroutes page
	When I follow "view_profile" 
	When I follow 'Show'
	Then I should see "Username: admin"
	Then I should see "Email: admin@admin.com"

Scenario: Delete user
	Given I am on the new user session page
  	And I fill in "user_session_username" with "admin"
  	And I fill in "user_session_password" with "admin1"
  	And I press "login"
  	And am on the traceroutes page
	When I follow "view_profile" 
	When I follow 'Remove'
	Then I should see "Login"