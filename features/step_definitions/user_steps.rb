Given /the following users exist/ do |users_table|
	users_table.hashes.each do |user|
		User.create(user)
	end	
end	


When /^Selenium sees the select boxes$/ do
  page.execute_script("$('#Requesttype_3').show();")
  page.execute_script("$('#Server_1').show();")
  page.execute_script("$('#Server_2').show();")
  page.execute_script("$('#Timeframe_4').show();")
end