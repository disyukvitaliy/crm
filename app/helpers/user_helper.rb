module UserHelper

  # if password and password_confirmation are not filled, assign nil to them
  # devise won't check these fields if they are nil
  # @param model_object [User]
  def self.update_passwords(model_object)
    model_object.update({
        password: model_object.password.blank? ? nil : model_object.password,
        password_confirmation: model_object.password_confirmation.blank? ? nil : model_object.password_confirmation,
    })
  end

  # @param user [User]
  # @return [Bool] true if either password or password_confirmation has errors
  def self.password_errors user
    user.errors[:password].any? || user.errors[:password_confirmation].any?
  end
end
