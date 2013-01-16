class Hypervisor < ActiveRecord::Base
	belongs_to :bridgeinterface, :class_name => 'Interface', :dependent => :destroy
	belongs_to :netinterface, :class_name => 'Interface', :dependent => :destroy
	belongs_to :host
	has_many :vms, :dependent => :destroy
	VIRT_TYPES = ['xen','kvm']

	validates_uniqueness_of :name, :scope => :host_id

end
