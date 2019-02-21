class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper
  
  private

    if @user.save
      redirect_to action: :show, id: @user.id
      flash[:success] = t(:succes_to_create_user)
    else
      render :new
      flash[:danger] = t(:fail_to_create_user)
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    redirect_to action: :new
    flash[:danger] = t(:fail_to_load_user)
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
