class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = List.where(user_id: current_user.id).order(created_at: :desc)
  end
end
