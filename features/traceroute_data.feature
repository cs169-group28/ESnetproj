Feature: See traceroute data between two servers
  As a network administrator 
  So that I can see how packets travel between two servers
  I want to be able to see aggregated traceroute data 

Background: Server information has been added to the database

  Given the following servers exist:

  | hostname                  | ip             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | lbl-pt1.es.net            | 453.145.31.65  |
  | lbl-owamp.es.net          | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |

   And I am on the traceroutes page

Scenario: View traceroute data between two servers
  When I select "lbl-pt1.es.net" from "Server_1"
  When I select "pppl-pt1.es.net" from "Server_2"
  When I select "TRACEROUTE" from "Requesttype_3"
  When I press 'route'
  Then I should see "lbl-pt1.es.net"
  Then I should see "ppl-pt1.es.net"

Scenario: View OWAMP data between two servers
  When I select "aofa-owamp.es.net" from "Server_1"
  When I select "lbl-owamp.es.net" from "Server_2"
  When I select "OWAMP" from "Requesttype_3"
  When I press 'route'
  Then I should see "lbl-owamp.es.net"
  Then I should see "aofa-owamp.es.net"