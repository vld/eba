class IssuesController < ApplicationController
  before_filter :autheticate!, :only => [:change_state, :take_issue]
  before_filter :get_issue, :except => [:index, :new, :create, :search]
  
  def index
    scoped = params[:scoped]
    if scoped
      if ['unassigned', 'closed'].include?(scoped)
        @issues = Issue.send(scoped)
      elsif scoped == 'open'
        @issues = Issue.without_states('completed', 'cancelled')
      elsif scoped == 'on hold'
        @issues = Issue.with_state('on_hold')
      end
    else
      @issues = Issue.all
    end
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = Issue.new(params[:issue])

    if @issue.save
      redirect_to @issue, notice: 'Issue was successfully created.'
    else
      render action: "new"
    end
  end

  def take
    @issue.manager = current_manager
    if @issue.save
      @issue.comments.create(body: "Issue got new assignee: #{@issue.manager.username}")
      redirect_to @issue, notice: 'Issue was assigned to you'
    else
      redirect_to @issue, error: 'Assigning occurs error'
    end
  end

  def change_state
    event = params[:event]
    if @issue.send(event)
      redirect_to @issue, notice: 'State was changed'
    else
      redirect_to @issue, error: 'State changing occurs error'
    end
  end

  def search
    query = params[:query]
    if query =~ /[A-Z]{3}-\d{5}/
      @issues = Issue.find_all_by_code(query)
    else
      @issues = Issue.where("body ilike ? OR subject ilike ?", "%#{query}%", " %#{query}% ")
    end
    render :template => 'issues/index'
  end

  def update
    if @issue.update_attributes(params[:issue])
      redirect_to @issue, notice: 'Issue was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @issue.destroy

    redirect_to issues_url
  end

  def get_issue
    @issue = Issue.find(params[:id])
  end
end
