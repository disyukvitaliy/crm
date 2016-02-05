module UserHelper

  # @param user_params [Hash] hash of permitted and required params
  # @return [Hash] params cleared of passwords of they blank?
  def self.clear_passwords(user_params)
    user_params.delete(:password) if user_params[:password].blank?
    user_params.delete(:password_confirmation) if user_params[:password_confirmation].blank?
    user_params
  end

  # @param user [User]
  # @return [Bool] true if either password or password_confirmation has errors
  def self.password_errors user
    user.errors[:password].any? || user.errors[:password_confirmation].any?
  end
end
