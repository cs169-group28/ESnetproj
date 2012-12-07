Feature: Query data on servers

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
  | lbl-owamp.es.net          | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |  

    And I am on the traceroutes page
    And Selenium sees the select boxes

@ignore-hidden-elements
@javascript
Scenario: View BWCTL data between two servers
  When I select "BWCTL" from "Requesttype[3]"
  When I select "lbl-pt1.es.net" from "Server_1"
  When I select "nersc-pt1.es.net" from "Server_2"
  When I select "1 month" from "Timeframe_4"
  When I press "route"
  Then I should see "lbl-pt1.es.net"
  Then I should see "nersc-pt1.es.net"

@ignore-hidden-elements
@javascript
Scenario: View a graphic of the traceroute data between two servers
  And Selenium sees the select boxes
  When I select "TRACEROUTE" from "Requesttype[3]"
  When I select "lbl-pt1.es.net" from "Server[1]"
  When I select "pppl-pt1.es.net" from "Server_2"
  When I select "4 hours" from "Timeframe_4"
  When I press 'route'
  Then I should see 2 nodes
  Then I should see "lbl-pt1.es.net"
  Then I should see "ppl-pt1.es.net"

@ignore-hidden-elements
@javascript
Scenario: View OWAMP data between two servers
  When I select "OWAMP" from "Requesttype_3"
  When I select "aofa-owamp.es.net" from "Server_1"
  When I select "lbl-owamp.es.net" from "Server_2"
  When I select "4 hours" from "Timeframe_4"
  When I press "route"
  Then I should see "lbl-owamp.es.net"
  Then I should see "aofa-owamp.es.net"
