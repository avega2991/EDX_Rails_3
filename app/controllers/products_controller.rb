class ProductsController < ApplicationController

  before_filter :find_group
  before_filter :find_product, :only => [:update, :edit, :destroy]

  def index
    @products = Product.find_all_by_group_id(params[:group_id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(params[:product])
    @product.update_attributes(:group_id => @group.id)
    redirect_to [@group, :products], :notice => "Product '#{@product.name}' has been created"
  end

  def edit
  end

  def update
    @old_product_name = @product.name

    if @product.update_attributes(params[:product])
      @notice = "Renaming has been finished: '#{@old_product_name}' => '#{@product.name}'"
      redirect_to [@group, :products], :notice => @notice
    else
      @notice = @product.errors.full_messages.to_s
      redirect_to :action => "edit", :notice => @notice
    end
  end

  def destroy
    @product.destroy

    redirect_to [@group, :products], notice: "Product '#{@product.name}' has been destroyed"
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
