class ShorewallrulesController < ApplicationController
	before_filter	:checkLogin

  # GET /shorewallrules
  # GET /shorewallrules.xml
  def index
    @shorewallrules = Shorewallrule.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shorewallrules }
    end
  end

  # GET /shorewallrules/1
  # GET /shorewallrules/1.xml
  def show
    @shorewallrule = Shorewallrule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shorewallrule }
    end
  end

  # GET /shorewallrules/new
  # GET /shorewallrules/new.xml
  def newShorewallrule
    @shorewallrule = Shorewallrule.new
		render :action => 'new'
  end

  # GET /shorewallrules/1/edit
  def edit
    @shorewallrule = Shorewallrule.find(params[:id])
		params[:host_id] = @shorewallrule.host.id
  end


  # POST /shorewallrules
  # POST /shorewallrules.xml
  def create
    @shorewallrule = Shorewallrule.new(params[:shorewallrule])
    if @shorewallrule.save
       redirect_to(edit_host_path(Host.find(params[:host_id])), :notice => 'Shorewallrule was successfully created.') 
    else
        render :action => "new" 
    end
  end

  # PUT /shorewallrules/1
  # PUT /shorewallrules/1.xml
  def update
    @shorewallrule = Shorewallrule.find(params[:id])
    if @shorewallrule.update_attributes(params[:shorewallrule])
     	redirect_to(edit_host_path(Host.find(params[:host_id])), :notice => 'Shorewallrule was successfully created.') 
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @shorewallrule.errors, :status => :unprocessable_entity }
    end
  end

  # DELETE /shorewallrules/1
  # DELETE /shorewallrules/1.xml
  def destroy
    @shorewallrule = Shorewallrule.find(params[:id])
    @shorewallrule.destroy
		redirect_to edit_host_path(@shorewallrule.host)
  end


	



end
