class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_list, only: [:show, :update, :unpack]

  def index
    @lists = List.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @list.items }
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if !(current_user.lists << @list)
      flash[:notice] = "You've already created a list with this name."
      render :new
    else
      flash[:notice] = "Your list has been created!"
      redirect_to list_path(@list)
    end
  end

  def unpack
    @list.items.each do |item|
      item.update_attribute(:packed, false)
    end
    redirect_to :back
  end

  private

  def list_params
    params.require(:list).permit(:name, :deadline_date, :deadline_time, :user_id)
  end

  def get_list
    @list = List.find(params[:id])
  end
end
