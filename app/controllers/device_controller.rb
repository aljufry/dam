class DeviceController < ApplicationController
  PER_PAGE = 10

 before_filter :has_logged_in

  def index
    redirect_to(:controller => 'subnets', :action => 'list')
  end

  def show

    #require 'snmp'
    #SNMP::Manager.open(:host => '127.0.0.1') do |manager|
    #
    #  response = manager.get(["sysDescr.0", "sysName.0"])
    #  response.each_varbind do |vb|
    #    @get_request=vb
    #    puts "GetRequesttttttttttttttttttttttttttttttttttttttt"
    #    puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"
    #    puts "GetRequesttttttttttttttttttttttttttttttttttttttt"
    #  end
    #end
    #@newdevices = Newdevice.all

    if params[:id] == nil
      redirect_to('/')
    else
      @device = Entry.find(params[:id])
      @devicetype=Newdevice.find_by_device_type(@device.device_type)
    end
  end

  def dynamic_form
    @newdevices = Newdevice.all
    @subnet = Subnet.find(params[:id])
    if (params[:entry_id])
      @entry=Entry.find(params[:entry_id])
    else
      @entry=Entry.new
    end
    if (params[:device_type_id]!=nil && params[:device_type_id]!="")
      @devicetype=Newdevice.find_by_device_type(params[:device_type_id])
    else
      if (Newdevice.first==nil)
        @devicetype=Newdevice.new
      else
        @devicetype=Newdevice.first
      end

    end
    render :layout =>false
  end
  def new
    @newdevices=Newdevice.all
    @subnet = Subnet.find_by_id(params[:id])
    @device = Entry.new
  end

  def list
    @interface=Interface.find_by_id(params[:id])
    if params[:id] == nil
      redirect_to(:controller => 'subnets', :action => 'list')
    else
      @subnet = Subnet.find_by_id(params[:id])
      if @subnet
        @devices = @subnet.entries.paginate({:page => params[:page], :per_page => PER_PAGE})
      else
        redirect_to(:controller => 'subnets', :action => 'list')
      end
    end
  end


  def view
    if params[:id] == nil
      redirect_to(:controller => 'subnets', :action => 'list')
    else
      @subnet = Subnet.find_by_id(params[:id])
      if @subnet
        @devices = @subnet.entries.paginate({:page => params[:page], :per_page => PER_PAGE})
      else
        redirect_to(:controller => 'subnets', :action => 'list')
      end
    end
  end

  def update
    @device= Entry.find(params[:id])
    subnet = @device.subnet
    user = recheck_logged_in_user
    if is_editor
      @device.update_author = user.username
      if @device.update_attributes(params[:device])
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list', :id => subnet.id)
      else
        render('edit')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('edit')
    end
  end

  def _form

  end

  def delete
    @device = Entry.find(params[:id])
    @subnet=@device.subnet
    #if (params[:nolayout])
      render :layout => nil
    #end
    end

  def edit
    @newdevices=Newdevice.all
    @device = Entry.find(params[:id])
    @subnet = @device.subnet
    @devicetype=Newdevice.find_by_device_type(@device.device_type)
  end
  def create
    @subnet = Subnet.find_by_id(params[:id])
    @device = Entry.new(params[:entry])
    user = recheck_logged_in_user
    if is_editor
      @device.author = user.username
      @device.subnet = @subnet
      if @device.save
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list', :id => @subnet.id)
      else
        render('new')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('new')
    end
  end

  def destroy

    @device = Entry.find(params[:id])
    subnet = @device.subnet
    user = recheck_logged_in_user
    if is_editor
      @device.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:action => 'list', :id => subnet.id)
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('delete')
    end

  #  @subnet= Subnet.find(params[:id])
  #  @device = Entry.find(params[:id])
  #  subnet  = @device.subnet
  #  user = recheck_logged_in_user
  #  if is_editor
  #    @device.destroy
  #    flash[:info] = t(:deleted_successfully)
  #    redirect_to(:action => 'list', :id => subnet.id)
  #  else
  #    flash[:notice] = t(:you_do_not_have_edit_privilege)
  #    render('delete')
  #  end
  end

  def getrequest
    require 'snmp'
    SNMP::Manager.open(:host => '127.0.0.1') do |manager|

      response = manager.get(["sysDescr.0", "sysName.0"])
      response.each_varbind do |vb|
        @get_request=vb
        puts "GetRequesttttttttttttttttttttttttttttttttttttttt"
        puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"
        puts "GetRequesttttttttttttttttttttttttttttttttttttttt"
      end
    end
  end

end
