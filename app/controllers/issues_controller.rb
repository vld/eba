class IssuesController < ApplicationController
  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def create
    @issue = Issue.new(params[:issue])

    if @issue.save
      redirect_to @issue, notice: 'Issue was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @issue = Issue.find(params[:id])

    if @issue.update_attributes(params[:issue])
      redirect_to @issue, notice: 'Issue was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    redirect_to issues_url
  end
end
