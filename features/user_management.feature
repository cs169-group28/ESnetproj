Feature: Manage user account
  As a perfSONAR toolkit user
  So that I can personalize my user account
  I want to be able to change my user information

Background: User information has been added to the database

  Given the following users exist:

  |username           | email                | password      | password_confirmation    |
  | new_admin         | new_admin@admin.com  | admin1        | admin1                   |
  | new_admin1        | new_admin1@admin.com | admin1        | admin1                   |

  	Given I am on the new user session page
  	And I fill in "user_session_username" with "new_admin"
  	And I fill in "user_session_password" with "admin1"
  	And I press "login"
  	And I am on the traceroutes page
  	And I follow "view_profile" 

Scenario: View user information
	When I follow "view_profile" 
	Then I should be on the users page
	And I should see "new_admin"
	And I should see "new_admin@admin.com"
	Then I should not see 'new_admin1'
	Then I should not see 'new_admin1@admin.com'

Scenario: Edit user information
	When I follow "view_profile" 
	When I follow 'Edit'
	Then I should see "Edit User"
	And I fill in "user_password" with "new_pass"
	And I fill in "user_password_confirmation" with "new_pass"
	And I press "save"
	Then I should see "User was successfully updated"

Scenario: Fail to edit user information
	When I follow "view_profile" 
	When I follow 'Edit'
	Then I should see "Edit User"
	And I fill in "user_username" with "new_admin1"
	And I press "save"
	Then I should see "Username has already been taken"

Scenario: Show user
	When I follow "view_profile" 
	When I follow 'Show'
	Then I should see "Username: new_admin"
	Then I should see "Email: new_admin@admin.com"

Scenario: Delete user
	When I follow 'Remove'
	Then I should see "Login"