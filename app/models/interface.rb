class Interface < ActiveRecord::Base

	has_one	:vm
	has_many :hypervisors_as_net , :foreign_key => 'netinterface_id' , :class_name => 'Hypervisor' 
	has_one :hypervisor_as_bridge , :foreign_key => 'bridgeinterface_id' , :class_name => 'Hypervisor'

	belongs_to :host
	has_many  :shorewallrules_as_source , :foreign_key => 'sourceinterface_id', :class_name => 'Shorewallrule' , :dependent => :destroy
	has_many  :shorewallrules_as_dest , :foreign_key => 'destinterface_id' , :class_name => 'Shorewallrule', :dependent => :destroy

	has_many  :shorewallpolicies_as_source , :foreign_key => 'sourceinterface_id', :class_name => 'Shorewallpolicy' , :dependent => :destroy
	has_many  :shorewallpolicies_as_dest , :foreign_key => 'destinterface_id' , :class_name => 'Shorewallpolicy', :dependent => :destroy


def shorewallrules
	shorewallrules_as_source + shorewallrules_as_dest
end

def shorewallpolicies
	shorewallpolicies_as_source + shorewallpolicies_as_dest
end

validates_uniqueness_of :ifname, :scope => :host_id
validates_format_of :mac, :with => /\A(?:[a-f0-9]{2}:){5}[a-f0-9]{2}\Z/i
validates_format_of :ipaddress, :with => /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/
validates_presence_of :ifname
validates_presence_of :shorewallname


end
