class Vm < ActiveRecord::Base

	belongs_to :hypervisor	
	belongs_to :interface, :dependent => :destroy	


	validates_presence_of :name,:mem,:cpus,:diskname
	validates_uniqueness_of :name, :scope => :hypervisor_id

	
end
