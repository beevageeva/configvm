class ShorewallpoliciesController < ApplicationController
  # GET /shorewallpolicies
  # GET /shorewallpolicies.xml
  def index
    @shorewallpolicies = Shorewallpolicy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shorewallpolicies }
    end
  end

  # GET /shorewallpolicies/1
  # GET /shorewallpolicies/1.xml
  def show
    @shorewallpolicy = Shorewallpolicy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shorewallpolicy }
    end
  end

  # GET /shorewallpolicies/new
  # GET /shorewallpolicies/new.xml
  def newShorewallpolicy
    @shorewallpolicy = Shorewallpolicy.new
		render :action => :new	
  end

  # GET /shorewallpolicies/1/edit
  def edit
    @shorewallpolicy = Shorewallpolicy.find(params[:id])
		params[:host_id] = @shorewallpolicy.host.id
  end

  # POST /shorewallpolicies
  # POST /shorewallpolicies.xml
  def create
    @shorewallpolicy = Shorewallpolicy.new(params[:shorewallpolicy])
    if @shorewallpolicy.save
      redirect_to(edit_host_path(Host.find(params[:host_id])), :notice => 'Shorewallrule was successfully created.') 
    else
        render :action => "new" 
    end
  end

  # PUT /shorewallpolicies/1
  # PUT /shorewallpolicies/1.xml
  def update
    @shorewallpolicy = Shorewallpolicy.find(params[:id])

     if @shorewallpolicy.update_attributes(params[:shorewallpolicy])
     		redirect_to(edit_host_path(Host.find(params[:host_id])), :notice => 'Shorewallrule was successfully created.') 
     else
        render :action => "edit" 
     end
  end

  # DELETE /shorewallpolicies/1
  # DELETE /shorewallpolicies/1.xml
  def destroy
    @shorewallpolicy = Shorewallpolicy.find(params[:id])
    @shorewallpolicy.destroy
		redirect_to edit_host_path(@shorewallpolicy.host)

  end
end
