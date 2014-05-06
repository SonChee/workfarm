class ProjectsController < ::AuthenticatableController
  before_action :authenticate_user!
end
