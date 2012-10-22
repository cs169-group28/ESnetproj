Feature: Remove a server from a list of servers

  As a network user 
  So that I can only deal with relevant server
  I want to be able to remove outdated servers

 Background: Server information has been added to the database

 	Given the follwing servers exist:

  | name                    	| location 		| IP 			 |
  | Berkeley Engineering DPT    | Berkeley      | 192.168.51.23  |
  | Lawrence Berkeley NL        | Berkeley      | 453.145.31.65  |
  | Moffitt Library		    	| Berkeley      | 652.168.12.45  |
  | PG&E power station          | Oakland  		| 453.168.45.99  |
  | Stanley Hall                | Berkeley  	| 234.168.15.23  |

  And I am on the PerfSONAR home page
  Then I should see 192.168.0.1

Scenario: Add a server with a specific ip address and name
	When I press "Destroy"
  Then I should be on the home page
	Then I should not see '192.168.0.1'

