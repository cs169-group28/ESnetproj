Feature: Add a server to list of servers

  As a network user 
  So that I can troubleshoot different servers
  I want to be able to add servers to a list to choose from

 Background: Server information has been added to the database

 	Given the following servers exist:

  | name                        | city        | ip             |
  | Berkeley Engineering DPT    | Berkeley    | 192.168.51.23  |
  | Lawrence Berkeley NL        | Berkeley    | 453.145.31.65  |
  | Moffitt Library             | Berkeley    | 652.168.12.45  |
  | PG&E power station          | Oakland     | 453.168.45.99  |
  | Stanley Hall                | Berkeley    | 234.168.15.23  |

  And I am on the servers page
  Then I should not see '192.168.0.1'

Scenario: Add a server with a specific ip address
	When I am on the new server page
  And I add the server '192.168.0.1'
  Then I should be on the server page for 6
	Then I should see "192.168.0.1"

