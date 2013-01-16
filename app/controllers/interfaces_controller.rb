class InterfacesController < ApplicationController
	before_filter	:checkLogin

	#there is a layout interfaces used to render interfaces file for shorewall	
	layout 'application'

  # GET /interfaces
  # GET /interfaces.xml
  def index
    @interfaces = Interface.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interfaces }
    end
  end


	def copysr
		interface = Interface.find(params[:id])
		interface.shorewallrules_as_source.each do |sr|
			newsr = Shorewallrule.new(sr.attributes)
			newsr.sourceinterface_id = params[:destid]
			newsr.save
		end
		interface.shorewallrules_as_dest.each do |sr|
			newsr = Shorewallrule.new(sr.attributes)
			newsr.destinterface_id = params[:destid]
			newsr.save
		end
		redirect_to(interface, :notice => 'SR.')
	end



  # GET /interfaces/1
  # GET /interfaces/1.xml
  def show
    @interface = Interface.find(params[:id])
		@shorewallrules = @interface.shorewallrules
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interface }
    end
  end

  # GET /interfaces/new
  # GET /interfaces/new.xml
  def newInterface
    @interface = Interface.new
		@interface.host_id = params[:host_id]
		render :action => 'new'
  end

  # GET /interfaces/1/edit
  def edit
    @interface = Interface.find(params[:id])
  end

  # POST /interfaces
  # POST /interfaces.xml
  def create
    @interface = Interface.new(params[:interface])

    respond_to do |format|
      if @interface.save
        format.html { redirect_to(@interface, :notice => 'Interface was successfully created.') }
        format.xml  { render :xml => @interface, :status => :created, :location => @interface }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interface.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interfaces/1
  # PUT /interfaces/1.xml
  def update
    @interface = Interface.find(params[:id])

    respond_to do |format|
      if @interface.update_attributes(params[:interface])
        format.html { redirect_to(@interface, :notice => 'Interface was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interface.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interfaces/1
  # DELETE /interfaces/1.xml
  def destroy
    @interface = Interface.find(params[:id])
    @interface.destroy
		redirect_to edit_host_path(@interface.host)
  end
end
