class Shorewallpolicy < ActiveRecord::Base
	belongs_to :sourceinterface, :class_name => 'Interface'
	belongs_to :destinterface, :class_name => 'Interface'
	SHOREWALL_ACTIONS = ["ACCEPT", "DROP" , "REJECT"]
	def host
		return self.sourceinterface.host if self.sourceinterface_id !=-1
		return self.destinterface.host if self.destinterface_id !=-1
	end
end
