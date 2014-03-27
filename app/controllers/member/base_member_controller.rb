class Member::BaseMemberController < ::AuthenticatableController
  before_action :authenticate_member!
end
