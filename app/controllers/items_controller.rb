class ItemsController < ApplicationController
  before_action :get_list, only: [:create, :new]

  # All of a user's items
  def index
    @items = Item.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if !(@list.items << @item) # Save and insert
      flash.now[:error] = @item.errors.full_messages.join(", ")
      render :new
    else
      current_user.items << @item
      flash[:success] = "Your item has been created!"
      redirect_to list_path(@list)
    end
  end

  def all
    @items = Item.where(user_id: current_user.id)
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category, :user_id)
  end

  def get_list
    @list = List.find(params[:list_id])
  end

end
