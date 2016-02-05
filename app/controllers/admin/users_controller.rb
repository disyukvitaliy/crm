class Admin::UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users_grid = UsersGrid.new(params[:userss_grid]) do |scope|
      scope.page(params[:page]).per(5)
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to action: :index
    else
      # exit
      render :new
    end
  end

  def update
    if @user.update(UserHelper.clear_passwords(user_params))
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        if @user.destroy
          render js: "window.location = '#{request.referer}'"
        else
          render :alert, locals: {alert: @user.errors.full_messages.join('\n')}
        end
      end
      format.html do
        if @user.destroy
          redirect_to users_path
        else
          render :edit
        end
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # @return Hash
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :status)
  end
end
