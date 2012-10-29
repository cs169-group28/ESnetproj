Feature: See traceroute data between two servers
  As a network administrator 
  So that I can see how packets travel between two servers
  I want to be able to see aggregated traceroute data 

Background: Server information has been added to the database

  Given the follwing servers exist:

  | name                      | location    | IP       |
  | Berkeley Engineering DPT  | Berkeley    | 192.168.51.23  |
  | Lawrence Berkeley NL      | Berkeley    | 453.145.31.65  |
  | Moffitt Library           | Berkeley    | 652.168.12.45  |
  | PG&E power station        | Oakland     | 453.168.45.99  |
  | Stanley Hall              | Berkeley    | 234.168.15.23  |     

  And I am on the PERFSonar  "traceroute" page

Scenario: View traceroute data between 192.168.51.23 and 453.168.45.99
  When I select 192.168.51.23
  And I select 453.168.45.99
  And I press "Route"
  Then I should be on the "Traceroute information" page
  And I should see "66.208.288.226, /\d{1,}ms, \d{1,}ms, \d{1,}ms$"