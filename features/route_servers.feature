Feature: View traceroute map

  As a network user 
  So that I can identify the problematic server that is causing the error
  I want to view the network path between two servers.

 Background: Server information has been added to the database

  Given the following servers exist:

  | name                        | city        | ip             |
  | Berkeley Engineering DPT    | Berkeley    | 192.168.51.23  |
  | Lawrence Berkeley NL        | Berkeley    | 453.145.31.65  |
  | Moffitt Library             | Berkeley    | 652.168.12.45  |
  | PG&E power station          | Oakland     | 453.168.45.99  |
  | Stanley Hall                | Berkeley    | 234.168.15.23  |

    And I am on the traceroutes page

Scenario: Display information about a pair of servers
  When I select "1" from "Server_1"
  When I select "3" from "Server_2"
  When I press "route"
  Then I should see "192.168.51.23"




