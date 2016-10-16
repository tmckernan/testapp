class AccountsController < ApplicationController
  def new
    @user = current_user.account || current_user.build_account
  end

  def create
    @user = current_user.build_account(account_params)
    if @user.save
      redirect_to root_path
    else
      flash.now[:alert] = "ERROR: #{@user.errors.full_messages}"
      render :new
    end
  end

  def destroy
    current_user.account.destroy
    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:username, :api_key)
  end
end
