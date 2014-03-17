class AgentController < ApplicationController
  PER_PAGE = 10

  #before_filter :has_logged_in

  def index
    @agent = @subnet.agents.paginate({:page => params[:page], :per_page => PER_PAGE})
    #redirect_to :controller => 'dashboard'
  end

  def show
    @agent = Agent.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agent }
    end
  end

  # AJAX /agents/load_interfaces
  def load_interfaces
    @interfaces = Agent.find(params[:id]).interfaces
    render :update do |page|
      page.replace_html 'interfaces_view', :partial => 'interfaces', :object => @interfaces
    end
  end



  # GET /agents/1/edit
  #def edit
  #  @agent = Agent.find(params[:id])
  #end


  # GET /agents/new
  # GET /agents/new.xml
  def new

    @agent = Agent.new
  end

  # POST /agents
  # POST /agents.xml



  def create

    @agent = Agent.new(params[:agent])


    #respond_to do |format|

      if @agent.save
        flash[:notice] = 'Agent was successfully created.'
        redirect_to(:controller=>'dashboard',:action=>'index')
        #format.html { redirect_to(@agent) }
        #format.xml  { render :xml => @agent, :status => :created, :location => @agent }
      else
        flash[:notice] = 'Agent was not created.'
        redirect_to(:controller=>'dashboard',:action=>'index')
      end
    end


  end