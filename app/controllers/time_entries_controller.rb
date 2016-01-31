class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  def index
    @time_entries_grid = TimeEntriesGrid.new(params[:time_entries_grid]) do |scope|
      scope.where(issue: params[:issue_id]).page(params[:page]).per(5)
    end
  end

  def show
  end

  def new
    @time_entry = Issue.find(params[:issue_id]).time_entries.new
  end

  def edit
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)

    if @time_entry.save
      redirect_to issue_path(@time_entry.issue_id)
    else
      render :new
    end
  end

  def update
    if @time_entry.update(time_entry_params)
      redirect_to issue_time_entries_path(@time_entry.issue_id)
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        if @time_entry.destroy
          render :js => "window.location = '#{request.referer}'"
        else
          render :alert, locals: {alert: @time_entry.errors.full_messages.join('\n')}
        end
      end
      format.html do
        if @time_entry.destroy
          redirect_to issue_time_entries_path(@time_entry.issue_id)
        else
          render :edit
        end
      end
    end
  end

  private
  def set_time_entry
    @time_entry = TimeEntry.find(params[:id])
  end

  def time_entry_params
    params.require(:time_entry).permit(:date, :issue_id, :activity_id, :amount, :comment)
  end
end
