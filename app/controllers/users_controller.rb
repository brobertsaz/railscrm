class UsersController < ApplicationController

  def dashboard
    @leads = Lead.where(lead_owner: current_user.email).to_a
    @tasks = Task.where(assigned_to: current_user.email).to_a
  end
end
