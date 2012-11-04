Feature: See traceroute data between two servers
  As a network administrator 
  So that I can see how packets travel between two servers
  I want to be able to see aggregated traceroute data 

Background: Server information has been added to the database

  Given the follwing servers exist:

  | hostname                  | IP             |
  | pppl-pt1.es.net           | 192.168.51.23  |
  | jgi-pt1.es.net            | 453.145.31.65  |
  | albu-owamp.es.net         | 652.168.12.45  |
  | aofa-owamp.es.net         | 453.168.45.99  |

  And I am on the PERFSonar  "traceroute" page

Scenario: View traceroute data between pppl-pt1.es.net and jgi-pt1.es.net
  When I select pppl-pt1.es.net
  And I select gi-pt1.es.net
  And I press "Route"
  Then I should be on the "Traceroute information" page
  And I should see "66.208.288.226, /\d{1,}ms, \d{1,}ms, \d{1,}ms$"