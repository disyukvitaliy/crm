class SessionsController < Devise::SessionsController
  layout 'authentication', only: :new
end
