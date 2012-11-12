Feature: Query data over a specific time period
  As a user of the perfSONAR toolkit
  So that I can find data over a certain period of time
  I want to be able to select a time range over which to query the perfSONAR database

Background: Server information has been added to the database

  Given the following servers exist:

  | hostname                  | ip             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | lbl-pt1.es.net            | 453.145.31.65  |
  | lbl-owamp.es.net          | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |

   And I am on the traceroutes page

Scenario: View a traceroute data between two servers for a specific time interval
  When I select "lbl-pt1.es.net" from "Server_1"
  When I select "pppl-pt1.es.net" from "Server_2"
  When I select "TRACEROUTE" from "Requesttype_3"
  When I select "2 days" from 'Time_duration 4'
  When I press 'route'
  Then I should see 2 nodes
  And I should see"lbl-pt1.es.net"
  And I should see "ppl-pt1.es.net"