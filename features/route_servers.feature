Feature: Map a route between two servers

  As a network user 
  So that I can easily visualize traceroute information
  I want to be able to see the geographic path between two servers

 Background: Server information has been added to the database

 	Given the follwing servers exist:

  | name                    	| location 		| IP 			 |
  | Berkeley Engineering DPT    | Berkeley      | 192.168.51.23  |
  | Lawrence Berkeley NL        | Berkeley      | 453.145.31.65  |
  | Moffitt Library		    	| Berkeley      | 652.168.12.45  |
  | PG&E power station          | Oakland  		| 453.168.45.99  |
  | Stanley Hall                | Berkeley  	| 234.168.15.23  |

  And I am on the PerfSONAR "Routing" page

Scenario: Select two servers and display route
	When I select 192.0.0.1 from "Server[1]"
  And I select 192.0.0.2 from "Server[2]"
  And I press "Route"
  Then I should be on the "Map" page
	Then I should see 192.0.0.1
  And I should see 192.0.0.2

