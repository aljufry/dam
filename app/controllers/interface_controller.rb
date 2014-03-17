class InterfaceController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in

  def index
    redirect_to(:controller => 'device', :action => 'list')
  end

  def list
    @device = Entry.find_by_id(params[:id])
    #@subnet = Subnet.find_by_id(params[:id])
    if params[:id] == nil
      redirect_to(:controller => 'device', :action => 'list')
    else
      @device = Entry.find_by_id(params[:id])
      if @device
        @interfaces = @device.interfaces.paginate({:page => params[:page], :per_page => PER_PAGE})
      else
        redirect_to(:controller => 'interfaces', :action => 'list')
      end
    end

  end

  def new
    @device = Entry.find(params[:id])
    @interface= Interface.new
    render :layout => nil
  end

    def show



        @interface= Interface.find(params[:id])
        @device= @interface.entry

      render :layout => nil
    end



  def delete
    @interface = Interface.find(params[:id])
    @device=@interface.entry
    render :layout => nil

  end



  def destroy

    @interface = Interface.find(params[:id])
    entry = @interface.entry
    user = recheck_logged_in_user
    if is_editor
      @interface.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:controller=>'device',:action => 'list', :id => entry.subnet.id)
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('delete')
    end
  end






  def edit
    @interface= Interface.find(params[:id])
    @device= @interface.entry
    render :layout => nil
  end

  def update

    @interface= Interface.find(params[:id])
    device = @interface.entry
    user = recheck_logged_in_user
    if is_editor
      @interface.author = user
      if @interface.update_attributes(params[:interface])
        flash[:info] = t(:saved_successfully)
        redirect_to(:controller=>'device',:action => 'list', :id => device.subnet.id)
      else
        render('edit')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('edit')
    end
  end

  def create


    @device = Entry.find(params[:id])

    @interface = Interface.new(params[:interface])
    user = recheck_logged_in_user
    unless params[:id]
     raise 'No ID'
    end

    if is_editor
      @interface.entry_id=params[:id].to_i
      @interface.author = user

      if @interface.save
        flash[:info] = "saved_successfully."
        redirect_to(:controller=>'device',:action => 'list', :id => @device.subnet.id)
      else
        render('new')
      end
    else
      flash[:notice] = "you_do_not_have_edit_privilege."
      render('new')
    end
  end
end
