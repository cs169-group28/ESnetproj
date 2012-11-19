class Server < ActiveRecord::Base

  attr_accessible :hostname, :ip, :categories, "Core Hosts".parameterize.underscore.to_sym, "Edge Hosts", "Exchange Points", "Smaller DOE Sites", "DICE Testing", "Main Hubs", "Large BWCTL DOE Sites", "Other BWCTL Hubs", "1G Testers", "OWAMP", "BWCTL", "TRACEROUTE"

end
