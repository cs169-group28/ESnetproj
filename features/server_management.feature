Feature: Manage a list of servers

  As a network user 
  So that I can organize the servers that I have data about
  I want to be able to manage a table of different servers

 Background: Server information has been added to the database

  Given the following servers exist:

  | hostname                  | ip             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | jgi-pt1.es.net            | 453.145.31.65  |
  | albu-owamp.es.net         | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |    

  Given the following users exist:

  | username           | email                | password      | password_confirmation    |
  | new_admin          | new_admin@admin.com  | admin1        | admin1                   |

  And I am on the new user session page
  And I fill in "user_session_username" with "new_admin"
  And I fill in "user_session_password" with "admin1"
  And I press "login"
  Then I should be on the traceroutes page

Scenario: Add a server with a specific hostname
  When I am on the new server page
  And I fill in "server_hostname" with "ornl2-pt1.es.net"
  And I press "create_server"
  Then I should see "ornl2-pt1.es.net"

Scenario: Remove a server with a specific ip address and name
  When I am on the new server page
  And I fill in "server_hostname" with "ornl2-pt1.es.net"
  And I press "create_server"
  And I follow "Delete"
  Then I should be on the servers page
  Then I should not see 'ornl2-pt1.es.net'

