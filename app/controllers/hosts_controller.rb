class HostsController < ApplicationController

	before_filter	:checkLogin  , :except => [:getShorewallRulesFile, :getShorewallPolicyFile, :getShorewallZonesFile, :getShorewallInterfacesFile]
	before_filter :authenticate_http, :only => [:getShorewallRulesFile, :getShorewallPolicyFile, :getShorewallZonesFile, :getShorewallInterfacesFile ]


	#Shorewall macros are not used
	##ACTION     SOURCE    DEST               PROTO     DEST PORT(S)
	#DNS(ACCEPT) $FW       net
#You don't have to use defined macros when coding a rule in /etc/shorewall/rules; Shorewall will start slightly faster if you code your rules directly rather than using macros. The the rule shown above could also have been coded as follows:
	##ACTION    SOURCE    DEST               PROTO     DEST PORT(S)
	#ACCEPT     $FW       net                udp       53
	#ACCEPT     $FW       net                tcp       53



  # GET /hosts
  # GET /hosts.xml
  def index
    @hosts = Host.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end


  # GET /hosts/new
  # GET /hosts/new.xml
  def new
    @host = Host.new
		
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # GET /hosts/1/edit
  def edit
    @host = Host.find(params[:id])
		@shorewallrules = getshorewallrules(@host)
		@shorewallpolicies = getshorewallpolicies(@host)
  end

  # POST /hosts
  # POST /hosts.xml
  def create
    @host = Host.new(params[:host])
      if @host.save
				if params[:has_bridge_interface] 
						@interface.host_id = @host.id
						@interface.save
				end	
        redirect_to(hosts_path, :notice => 'Host was successfully created.') 
      else
        render :action => "new" 
      end
  end

  # PUT /hosts/1
  # PUT /hosts/1.xml
  def update
    @host = Host.find(params[:id])
    if @host.update_attributes(params[:host])
      redirect_to(hosts_path, :notice => 'Host was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.xml
  def destroy
    @host = Host.find(params[:id])
    @host.destroy

    respond_to do |format|
      format.html { redirect_to(hosts_url) }
      format.xml  { head :ok }
    end
  end

	def getShorewallZonesFile
		host = Host.find_by_name(params[:host_name])
		result = "fw\tfirewall\n"
		host.interfaces.each do |i|
			result+="#{i.shorewallname}\tipv4\n"
		end	
		result = render_to_string(:text => result,:layout => "zones")
		send_data(result, :filename => "zones")
	end

	def getShorewallInterfacesFile
		host = Host.find_by_name(params[:host_name])
		result=""
		host.interfaces.each do |i|
			result+="#{i.shorewallname}\t#{i.ifname}\tdetect\t#{i.shorewalloptions}\n"
		end
		result = render_to_string(:text => result,:layout => "interfaces")
		send_data(result, :filename => "interfaces" )
	end

	def getShorewallRulesFile
		host = Host.find_by_name(params[:host_name])
		res = []
		result = ""
		host.interfaces.each do |i|
			if !i.vm || i.vm.enabled
				result+="#rules for interface #{i.ifname}\n"
				#TODO i.shorewallrules_as_source  won't work because FW is not included in the interfaces
				i.shorewallrules.each do |r|
					if (r.destinterface_id == -1 || !r.destinterface.vm || r.destinterface.vm.enabled) && res.find_index(r).nil?
						result +=r.to_s
						result += "\n"
						res.push(r)
					end
				end
			end
		end
		result = render_to_string(:text => result,:layout => "rules")
		send_data(result, :filename => "rules")
	end

	def getShorewallPolicyFile
		host = Host.find_by_name(params[:host_name])
		res = []
		result = ""
		host.hypervisors.each do |h|
			if h.bridgeinterface
				result+="#policy for bridge interface \n"
				result += "$FW\t#{h.bridgeinterface.shorewallname}\tACCEPT \n"
				result += "#{h.bridgeinterface.shorewallname}	#{h.netinterface.shorewallname}\tACCEPT \n"
			end
		end
		host.interfaces.each do |i|
			result+="#policy for interface #{i.shorewallname}\n"
			if i.vm
				if i.vm.hypervisor.bridgeinterface_id.nil?
					result += "$FW\t#{i.shorewallname}\tACCEPT \n"
					result += "#{i.shorewallname}\t#{i.vm.hypervisor.netinterface.shorewallname}\tACCEPT \n"
				end
				result += "#{i.shorewallname}\t$FW\tDROP\tinfo \n"
			else
				#TODO i.shorewallrules_as_source  won't work because FW is not included in the interfaces
				i.shorewallpolicies.each do |r|
					#TODO no check as interfaces should only be FW or no VM
					if (r.destinterface_id == -1 || r.destinterface.vm.nil?) && res.find_index(r).nil?
						result +=r.sourceinterface_id == -1 ? "$FW" : r.sourceinterface.shorewallname
						result += "\t"
						result +=r.destinterface_id == -1 ? "$FW" : r.destinterface.shorewallname
						result += "\t"
						result +=r.action
						result += "\t"
						result +=r.loglevel 
						result += "\n"
						res.push(r)
					end
				end
			end
		end
		result+="all\tall\tREJECT\tinfo\n"
		result = render_to_string(:text => result,:layout => "policy")
		send_data(result, :filename => "policy")
	end

	



	def getshorewallrules(host)
		res = []
		host.interfaces.each do |i|
			i.shorewallrules.each do |r|
				res.push(r) if res.find_index(r).nil?
			end
		end
		return res
	end



	def getshorewallpolicies(host)
		res = []
		host.interfaces.each do |i|
			i.shorewallpolicies.each do |r|
				res.push(r) if res.find_index(r).nil?
			end
		end
		return res
	end


end
