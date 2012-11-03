# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Server.delete_all

seedFiles = ['traceroute-seed.txt', 'owamp-seed.txt', 'bwctl-seed.txt']
seedFolder = 'app/assets/'

seedFiles.each do |fileName|
	File.open(seedFolder + fileName) do |servers|
		servers.read.each_line do |hostname|
			Server.find_or_create_by_hostname(hostname.chomp.strip)
		end
	end
end
