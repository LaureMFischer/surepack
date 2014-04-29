class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_list, only: [:show, :update, :unpack, :edit, :update]

  def index
    @lists = current_user.lists.order(created_at: :desc)
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
      flash[:alert] = "You've already created a list with this name."
      render :new
    else
      flash[:notice] = "Your list has been created!"
      redirect_to list_path(@list)
    end
  end

  def edit
  end

  def update
    @list.assign_attributes(list_params)
    if @list.save
      flash[:notice] = 'Updated the list!'
      redirect_to list_path(@list)
    else
      flash.now[:errors] = @list.errors.full_messages
      render :edit
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
