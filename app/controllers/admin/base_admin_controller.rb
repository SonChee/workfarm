class Admin::BaseAdminController < ::AuthenticatableController
  before_action :authenticate_admin!
end
