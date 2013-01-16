class HypervisorsController < ApplicationController


before_filter :authenticate_http, :only => [ :post ]
before_filter	:checkLogin  , :except => [:post]



  # GET /hypervisors
  # GET /hypervisors.xml
  def index
    @hypervisors = Hypervisor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hypervisors }
    end
  end

  # GET /hypervisors/1
  # GET /hypervisors/1.xml
  def show
    @hypervisor = Hypervisor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hypervisor }
    end
  end


	def post 
		if !params[:hypervisor_name] || !params[:host_name] || !params[:arg1]
			ActiveRecord::Base.logger.warn "params hypervisor_name, host_name and arg1 must be sent"
			render :text => "params hypervisor_name ,host_name and arg1 must be sent"
			return
		end
		hypervisor = Hypervisor.includes(:host).where("hypervisors.name = ? and hosts.name = ?", params[:hypervisor_name], params[:host_name]).first
		if params[:arg1] == "list"
			action = "list"
		elsif (params[:arg1] == "create" && hypervisor.virttype == "xen") || (params[:arg1] == "start" && hypervisor.virttype == "kvm") 
			action = "enablevm"
		elsif params[:arg1] == "destroy"  || params[:arg1] == "shutdown" 
			action = "disablevm"
		end
		if action == "enablevm" || action == "disablevm"
			if(!params[:arg2])
				render :text => "param arg2 must be sent as the vm name"
				return
			end
			vm = Vm.where("hypervisor_id=? and name=?", hypervisor.id, params[:arg2]).first
			vm.enabled = (action=="enablevm")
			res = vm.save
			render :text => "result save: #{res},#{vm.name} enabled = #{vm.enabled}"
			return
		end
		if action == "list"
			res = "LIST:\n"
			if params[:result]
				lines = params[:result].split("\n")
				enabled = []
				lines[2..-1].each do |line|
					fields = line.split("\s")
					vmname = fields[0] 
					enabled.push(vmname)
				end
				enablecount = 0
				hypervisor.vms.each do|hvm|
					if enabled.include?(hvm.name)
						enablecount+=1
						hvm.enabled = true
					else
						hvm.enabled = false
					end
					s = hvm.save 
					res+="#{hvm.name} enabled = #{hvm.enabled}"
					res+=",save result = FALSE" if !s
					res+="\n"
				end
				if enablecount != enabled.length
					res+="there are vms not defined in configvm enablecount = #{enablecount} and enabled.length = #{enabled.length}, enabled array = #{enabled.join(",")}\n"
				end
				ActiveRecord::Base.logger.warn "CHANGED LIST #{res}"
			else
				res += "param result must be sent as list result"
			end
			render :text => res
			return
		end
		render :text => "UNKNOWN arg1:#{params[:arg1]} , arg2:#{params[:arg2]}"
	end



  # GET /hypervisors/new
  # GET /hypervisors/new.xml
  def newHypervisor
    @hypervisor = Hypervisor.new
		@hypervisor.host_id = params[:host_id]
		#bridge interface
		@interface = Interface.new
		@interface.host_id = params[:host_id]

		render :action => 'new'	
  end

  # GET /hypervisors/1/edit
  def edit
    @hypervisor = Hypervisor.find(params[:id])
		#bridge interface
		if @hypervisor.bridgeinterface
			@interface = @hypervisor.bridgeinterface
		else
			@interface = Interface.new
			@interface.host_id = @hypervisor.host.id
		end
  end

  # POST /hypervisors
  # POST /hypervisors.xml
  def create
    @hypervisor = Hypervisor.new(params[:hypervisor])
		#if params[:has_bridge_interface]  && ActiveRecord::ConnectionAdapters::Column.value_to_boolean(params[:has_bridge_interface])  
		Interface.transaction do
			saved = true	
			if params[:has_bridge_interface] 
				@interface = Interface.new(params[:interface])
				saved = @interface.save
				@hypervisor.bridgeinterface_id = @interface.id
			end
	    if saved && @hypervisor.save
				redirect_to(edit_host_path(@hypervisor.host), :notice => 'Hypervisor was successfully created.') 		
				return
			else
				raise  ActiveRecord::Rollback
			end
		end
		render :action => 'new'
  end

  # PUT /hypervisors/1
  # PUT /hypervisors/1.xml
  def update
    @hypervisor = Hypervisor.find(params[:id])
		saved = true
		if params[:has_bridge_interface]
			if @hypervisor.bridgeinterface
				@interface = @hypervisor.bridgeinterface
				saved = @interface.update_attributes(params[:interface])
			else
				@interface = Interface.new(params[:interface])
				@interface.host_id = @hypervisor.host.id
				saved = @interface.save
				@hypervisor.bridgeinterface_id = @interface.id
			end
		else
			@hypervisor.bridgeinterface.destroy if @hypervisor.bridgeinterface
			@hypervisor.bridgeinterface_id = nil
		end 
     if saved && @hypervisor.update_attributes(params[:hypervisor])
			redirect_to(edit_host_path(@hypervisor.host), :notice => 'Hypervisor was successfully updated.') 	
		else
			render :action => 'edit'	
		end
  end

  # DELETE /hypervisors/1
  # DELETE /hypervisors/1.xml
  def destroy
    @hypervisor = Hypervisor.find(params[:id])
    @hypervisor.destroy
		redirect_to(edit_host_path(@hypervisor.host), :notice => 'Hypervisor was successfully deleted.') 	
  end



end
