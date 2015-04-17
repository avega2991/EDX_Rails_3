class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(params[:group])
    redirect_to groups_path, :notice => "Group '" << @group.name << "' has been created"
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @notice = "Renaming has been finished: '" << @group.name << "' => '"

    @group.name = params[:group][:name]
    @group.save
    @notice << @group.name << "'"

    redirect_to groups_path, :notice => @notice
  end

  def destroy
    @group = Group.find(params[:id])
    @notice = "Group '" << @group.name << "' has been deleted"
    @products = @group.products.each { |p|
      p.destroy
    }
    @group.destroy

    redirect_to groups_path, :notice => @notice
  end

end
