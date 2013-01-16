module HostsHelper



	#do not add bridge interfaces
	def getIfnames(host_id)
		res = []
		host =  Host.find(host_id)
		res.push(['FW' , -1])
		host.hypervisors.each do |h|	
			h.vms.each do |vm|
				res.push([h.name + ":" + vm.name + " NETW INT", vm.interface_id])
			end
		end
		host.interfaces.each do |i|
			res.push([i.shorewallname, i.id]) if res.find{|x| x[1]==i.id}.nil? &&  i.vm.nil? && i.hypervisor_as_bridge.nil?
		end
		return res
		
	end

	def getIfnamesNoVM(host_id)
		res = [['FW','-1']]
		host =  Host.find(host_id)
		host.interfaces.each do |i|
			res.push([i.shorewallname, i.id]) if i.vm.nil? && i.hypervisor_as_bridge.nil?
		end
		return res
	end

	def getIfnamesNoVMNoFw(host_id)
		res = []
		host =  Host.find(host_id)
		host.interfaces.each do |i|
			res.push([i.ifname, i.id]) if i.vm.nil? && i.hypervisor_as_bridge.nil?
		end
		return res
	end

	def getVMInterfaces(host_id)
		res = []
		Host.find(host_id).interfaces.each do |i|
			res.push(i.id) if i.vm
		end
		return res	

	end

	def getIfnamesVMExcept(host_id, vmname)
		res = []
		Host.find(host_id).interfaces.each do |i|
			if i.vm && i.vm.name != vmname
				res.push([i.vm.name, i.id]) 		
			end
		end
		return res	
	end


	def random_color
	s="#"
	for i in 1..3 do
		s+= "%02X" % rand(256)
	end
	s
	end


end
