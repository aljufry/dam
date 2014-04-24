class NewdeviceController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in
  def index
    list
    render('list')
  end

  def new
    # display the new Device form
    @newdevice = Newdevice.new
  end

  def create
    @newdevice = Newdevice.new(params[:newdevice])
    user = recheck_logged_in_user
    if is_editor
      @newdevice.author = user.username
      if @newdevice.save
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list')
      else
        render('new')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('new')
    end
  end


  def list
    @newdevices = Newdevice.paginate({:page => params[:page], :per_page => PER_PAGE})
  end

  def view
  end

  def delete
    @newdevice = Newdevice.find(params[:id])
    render :layout=>nil
  end

  def destroy
    @newdevice = Newdevice.find(params[:id])
    user = recheck_logged_in_user
    if is_editor
      @newdevice.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:action => 'list')
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('delete')
    end
  end

  def edit
    @newdevice = Newdevice.find(params[:id])
  end
  def update
    @newdevice = Newdevice.find(params[:id])
    user = recheck_logged_in_user
    if is_editor
      @newdevice.update_author = user.username
      if @newdevice.update_attributes(params[:newdevice])
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list')
      else
        render('edit')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('edit')
    end
  end

  def show
    if params[:id] == nil
      redirect_to('/')
    else
      @newdevice = Newdevice.find(params[:id])
    end
  end
end
