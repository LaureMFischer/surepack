class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = List.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if !@list.save
      flash.now[:error] = @list.errors.full_messages.join(", ")
      render :new
    else
      flash[:success] = "Your list has been created!"
      redirect_to list_path(@list)
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :deadline_date, :deadline_time, :user_id)
  end
end
