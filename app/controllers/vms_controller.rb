require 'securerandom'

class VmsController < ApplicationController
	before_filter	:checkLogin
  # GET /vms
  # GET /vms.xml
  def index
    @vms = Vm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vms }
    end
  end

  # GET /vms/1
  # GET /vms/1.xml
  def show
    @vm = Vm.find(params[:id])
		@interface = @vm.interface
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vm }
    end
  end

  # GET /vms/new
  # GET /vms/new.xml
  def newVm
    @vm = Vm.new
		@vm.hypervisor_id = params[:hypervisor_id]
		@interface = Interface.new
		@interface.host_id = Hypervisor.find(params[:hypervisor_id]).host_id
		render :action => 'new'
  end

  # GET /vms/1/edit
  def edit
    @vm = Vm.find(params[:id])
		@interface = @vm.interface	
  end

  # POST /vms
  # POST /vms.xml
  def create
    @vm = Vm.new(params[:vm])
		@vm.uuid = SecureRandom.uuid
    @interface = Interface.new(params[:interface])
		Interface.transaction do	
			if @interface.save
				@vm.interface_id = @interface.id
	      if @vm.save
	        redirect_to(@vm, :notice => 'Vm was successfully created.')
					return
				else
					raise  ActiveRecord::Rollback
				end
			end
		end
    render :action => "new" 
  end

	def changeStatus
    @vm = Vm.find(params[:vm_id])
		@vm.enabled = !@vm.enabled
		if	@vm.save
			flash[:notice] = "Estado cambiado"
		end
    redirect_to(edit_hypervisor_path(@vm.hypervisor)) 

	end


  # PUT /vms/1
  # PUT /vms/1.xml
  def update
    @vm = Vm.find(params[:id])
		@interface = @vm.interface
    if @vm.update_attributes(params[:vm])
			if @interface.update_attributes(params[:interface])
	       redirect_to(@vm, :notice => 'Vm was successfully updated.') 
        return
			end
		end
   render :action => "edit" 
  end

  # DELETE /vms/1
  # DELETE /vms/1.xml
  def destroy
    @vm = Vm.find(params[:id])
    @vm.destroy
		redirect_to edit_hypervisor_path(@vm.hypervisor) 
  end
end
