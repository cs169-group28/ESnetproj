Feature: Search for a server
  As a network administrator 
  So that I can find a specific server to search with
  I want to be able to search

Background: Server information has been added to the database

  Given the following servers exist:

  | hostname                  | ip             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | lbl-pt1.es.net            | 453.145.31.65  |
  | lbl-owamp.es.net          | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |

  Given the following users exist:

  |username       | email            | password      | password_confirmation    |
  | admin         | admin@admin.com  | admin1        | admin1                   |

   

@culerity
Scenario: Search for a server by ip
  Given I am on the new user session page
  And I fill in "user_session_username" with "admin"
  And I fill in "user_session_password" with "admin1"
  And I press "login"
  And I am on the servers page
  Then I should see 10 servers
  And I should see "pppl-pt1.es.net"

Scenario: Search for a server by part of its name
  When I fill in "search_param" with "lbl"
  And I press "search"
  Then I should be on the servers page
  And I should see "lbl-pt1.es.net"
  And I should see "lbl-owamp.es.net"

Scenario: Search for a server that doesn't exist
  When I fill in "search_param" with "lblalala"
  And I press "search"
  Then I should be on the servers page
  And I should see "No servers found"
  
