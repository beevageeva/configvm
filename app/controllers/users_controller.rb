require 'ldap'

class UsersController < ApplicationController

  def verifyLogin

		if params[:login].nil? or params[:password].nil?
			flash[:notice] = "User and pass required"
			redirect_to  login_url 
			return
		end
		$HOST =  'exthost.saii.ull.es'
		$PORT =    LDAP::LDAP_PORT
		base  = "dc=saii, dc=ull, dc=es"
		groupbase = "ou=Group"
		userbase = "ou=People"
		filter = '(cn=saiiadmin)'
		attrs = ['memberUid']
		conn = LDAP::Conn.new($HOST, $PORT)
		ActiveRecord::Base.logger.warn   "bind as uid=#{params[:login]}, #{base}"
		conn.bind(dn="uid=#{params[:login]}, #{userbase} ,#{base}",password=params[:password] , method=LDAP::LDAP_AUTH_SIMPLE) do
			conn.search("#{groupbase}, #{base}", LDAP::LDAP_SCOPE_SUBTREE, filter, attrs) do | entry|
				if entry.vals('memberUid').find_index(params[:login])
	      	flash[:notice] = 'Login ok'
					session[:username] = params[:login]
	      	redirect_to  hosts_url
					return 
				end
			end
		end
		flash[:notice] = "Usuario invalido"
		redirect_to  login_url 
  end

	def home 
	render
	end


  def login
    render
  end


  def logout
    session[:username] = nil
    redirect_to hosts_url
  end


end
