class ItemsController < ApplicationController
  before_action :get_list

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if !@item.save
      flash.now[:error] = @item.errors.full_messages.join(", ")
      render :new
    else
      flash[:success] = "Your item has been created!"
      redirect_to list_path(@list)
    end
  end

  def all
    @items = Item.all
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category, :user_id)
  end

  def get_list
    @list = List.find(params[:list_id])
  end

end
