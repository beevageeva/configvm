class Shorewallrule < ActiveRecord::Base

	belongs_to :sourceinterface, :class_name => 'Interface'
	belongs_to :destinterface, :class_name => 'Interface'


	SHOREWALL_ACTIONS = ["ACCEPT", "DNAT"]
	SHOREWALL_PROTOCOLS = ["udp", "tcp" , "icmp"]



	#used for getting shorewall rules file and  in views/shorewallrules/_list
	def to_s
		res = self.action + "\t"
    if self.sourceinterface_id !=-1
			ipaddresslist =  self.sourceipaddresslist if self.sourceipaddresslist!=""
			shname = self.sourceinterface.shorewallname
			if self.sourceinterface.vm 
				ipaddresslist = self.sourceinterface.ipaddress
				if self.sourceinterface.vm.hypervisor.bridgeinterface
					shname =  self.sourceinterface.vm.hypervisor.bridgeinterface.shorewallname
				end
			end
      res += shname
      res+= ":" + ipaddresslist if ipaddresslist
    else 
       res+="$FW"
    end 
    res+="\t"
    if self.destinterface_id !=-1 
			ipaddresslist =  self.destipaddresslist if self.destipaddresslist!=""
			shname = self.destinterface.shorewallname
			if self.destinterface.vm 
				ipaddresslist = self.destinterface.ipaddress
				if self.destinterface.vm.hypervisor.bridgeinterface
					shname =  self.destinterface.vm.hypervisor.bridgeinterface.shorewallname
				end
			end
      res += shname 
      res+= ":" + ipaddresslist if ipaddresslist
    else 
       res+="$FW"
     end 
    res+= ":" + self.destport if self.destport!=""
    res+="\t"
    res+= self.protocoltype 
    res+="\t"
    res+= self.fwport 
		return res
	end


	def host
		return self.sourceinterface.host if self.sourceinterface_id !=-1
		return self.destinterface.host if self.destinterface_id !=-1
	end


end
