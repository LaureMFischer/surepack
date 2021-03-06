class ItemsController < ApplicationController
  before_action :get_list, only: [:create, :new, :update]

  # All of a user's items
  def index
    @items = current_user.items
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
    if !(@list.items << @item) # Save and insert into the list
      flash[:alert] = "You've already created this item!"
      render :new
    else
      current_user.items << @item
      redirect_to list_path(@list)
      flash[:notice] = "Your item has been created!"
    end
  end

  def update
    @item = Item.find(params[:id])
    @list.items << @item
    render json: @item
  end

  def packed
    if params[:items_checkbox]
      params[:items_checkbox].each do |check|
        item_id = check
        item = Item.find_by_id(item_id)
        item.update_attribute(:packed, true)
      end
      redirect_to :back
      flash[:notice] = "Your list has been saved!" # Saving the list updates any checked off items, packed attribute becomes true
    else
      redirect_to :back
      flash[:notice] = "You haven't checked anything off yet. Start packing!"
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category, :user_id)
  end

  def get_list
    @list = List.find(params[:list_id])
  end

end
