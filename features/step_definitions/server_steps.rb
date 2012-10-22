Given /the following servers exist/ do |servers_table|
  servers_table.hashes.each do |server|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Server.create(server)
  end
end

And /^I add the server:(.*)$/ do |server_details|
  details = server_details.to_s.gsub(/\s/, "").split(",")
  ip = details[0]
  step %Q{I fill in "IP" with "#{ip}"}
  step %Q{I press "Save Changes"}
end

