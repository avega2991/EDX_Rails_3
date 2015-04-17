class ProductsController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    @products = Product.find_all_by_group_id(params[:group_id])
  end

  def new
    @group = Group.find(params[:group_id])
    @product = Product.new(:group_id => @group.id)
  end

  def create
    @product = Product.create(:group_id => params[:group_id], :name => params[:product][:name])
    redirect_to group_products_path(params[:group_id]), :notice => "Product '" << @product.name << "' has been created"
  end

  def edit
    @group = Group.find(params[:group_id])
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @notice = "Renaming has been finished: '" << @product.name << "' => '"

    @product.name = params[:product][:name]
    @product.save
    @notice << @product.name << "'"

    redirect_to group_products_path(params[:group_id]), :notice => @notice
  end

  def destroy
    @product = Product.find(params[:id])
    @notice = "Product '" << @product.name << "' has been destroyed"
    @product.destroy

    redirect_to group_products_path(params[:group_id], notice: @notice)
  end

  private

  def find

  end

end
