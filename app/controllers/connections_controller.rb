class ConnectionsController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in

  def index
    redirect_to(:controller => 'connections', :action => 'list')
  end

  def list
    if params[:id] == nil
      redirect_to(:controller => 'subnets', :action => 'list_view')
    else
      @subnet = Subnet.find_by_id(params[:id])
      if @subnet
        @connections = @subnet.connections.paginate({:page => params[:page], :per_page => PER_PAGE})
      else
        redirect_to(:controller => 'connections', :action => 'list')
      end
    end
  end

  def new
    @subnet = Subnet.find(params[:id])
    @connection= Connection.new
  end

  def show
    if params[:id] == nil
      redirect_to('/')
    else
    @connection = Connection.find(params[:id])
    end
  end

  def delete
    @connection = Connection.find(params[:id])
  end

  def destroy
    @connection = Connection.find(params[:id])
    subnet  = @connection.subnet
    user = recheck_logged_in_user
    if is_editor
      @connection.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:action => 'list', :id => subnet.id)
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('delete')
    end
  end

  def edit
    @connection= Connection.find(params[:id])
    @subnet= @connection.subnet
  end

  def update
    @connection= Connection.find(params[:id])
    subnet = @connection.subnet
    user = recheck_logged_in_user
    if is_editor
      @connection.author = user
      if @connection.update_attributes(params[:connection])
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

  def create
    @subnet = Subnet.find(params[:id])
    @connection = Connection.new(params[:connection])
    user = recheck_logged_in_user
    if is_editor
      @connection.subnet_id=params[:id].to_i
      @connection.author = user
      @connection.subnet = @subnet
      if @connection.save
        flash[:info] = "saved_successfully."
        redirect_to(:action => 'list', :id => @subnet.id)
      else
        render('new')
      end
    else
      flash[:notice] = "you_do_not_have_edit_privilege."
      render('new')
    end
  end
end
