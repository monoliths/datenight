class RegistrationsController < Devise::RegistrationsController
  # since we are using "name" for Users in addition to what devise provides,
  # we have to allow the "name" to param to be passed to param
  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :current_password)
  end
end
