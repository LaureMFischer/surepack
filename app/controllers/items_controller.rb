class ItemsController < ApplicationController
  before_action :get_list, only: [:create, :new, :update]

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

  def update
    @item = Item.find(params[:id])
    @list.items << @item
    render json: @item
  end

  def all
    @items = Item.where(user_id: current_user.id)
  end

  def packed
    params[:items_checkbox].each do |check|
      item_id = check
      item = Item.find_by_id(item_id)
      item.update_attribute(:packed, true)
    end
    redirect_to :back
    flash[:success] = "Your list has been saved!"
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category, :user_id)
  end

  def get_list
    @list = List.find(params[:list_id])
  end

end
