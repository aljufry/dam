class IpSubnetController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in
  def delete
  end

  def edit
  end

  def list
    @interface = Interface.find_by_id(params[:id])
    @device = Entry.find_by_id(params[:id])
    @subnet = Subnet.find_by_id(params[:id])
    if params[:id] == nil
      redirect_to(:controller => 'interface', :action => 'list')
    else
      @interface = Interface.find_by_id(params[:id])
      if @interface
        @ip_subnets = @interface.ip_subnet.paginate({:page => params[:page], :per_page => PER_PAGE})
      else
        redirect_to(:controller => 'ip_subnet', :action => 'list')
      end
    end
  end


  def new
    @device = Entry.find(params[:id])
    @interface= Interface.find(params[:id])
    @ip_subnet= IpSubnet.new
  end

  def create
    @interface = Interface.find(params[:id])
    @ip_subnet = IpSubnet.new(params[:ip_subnet])
    user = recheck_logged_in_user
    unless params[:id]
      raise 'No ID'
    end

    if is_editor
      @ip_subnet.interface_id=params[:id].to_i
      @ip_subnet.author = user

      if @ip_subnet.save
        flash[:info] = "saved_successfully."
        redirect_to(:action => 'list', :id => @interface.id)
      else
        render('new')
      end
    else
      flash[:notice] = "you_do_not_have_edit_privilege."
      render('new')
    end
  end
end
