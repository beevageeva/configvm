class Host < ActiveRecord::Base


	has_many :interfaces, :dependent => :destroy
	has_many :hypervisors, :dependent => :destroy


	validates_uniqueness_of :name




end
