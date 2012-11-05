Feature: View traceroute map

  As a network user 
  So that I can identify the problematic server that is causing the error
  I want to view the network path between two servers.

 Background: Server information has been added to the database

  Given the following servers exist:

  | hostname                  | ip             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | jgi-pt1.es.net            | 453.145.31.65  |
  | nersc-pt1.es.net          | 652.168.12.45  |
  | lbl-pt1.es.net            | 453.168.45.99  |   

    And I am on the traceroutes page

Scenario: Display information about a pair of servers
  When I select "lbl-pt1.es.net" from "Server_1"
  When I select "nersc-pt1.es.net" from "Server_2"
  When I select "BWCTL" from "Requesttype_3"
  When I press "route"
  Then I should see "lbl-pt1.es.net"
  Then I should see "nersc-pt1.es.net"




