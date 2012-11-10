Feature: See a graphical visualization of the path of the traceroute
  As a network administrator 
  So that I can see how packets travel between two servers
  I want to see a graphical representation of a traceroute

Background: Server information has been added to the database

  Given the following servers exist:

  | hostname                  | ip             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | lbl-pt1.es.net            | 453.145.31.65  |
  | lbl-owamp.es.net          | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |

   And I am on the traceroutes page

Scenario: View a graphic of the traceroute data between two servers
  When I select "lbl-pt1.es.net" from "Server_1"
  When I select "pppl-pt1.es.net" from "Server_2"
  When I select "TRACEROUTE" from "Requesttype_3"
  When I press 'route'
  Then I should see 2 nodes
  And I should see"lbl-pt1.es.net"
  And I should see "ppl-pt1.es.net"
