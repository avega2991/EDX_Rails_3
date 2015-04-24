class GroupsController < ApplicationController

  before_filter :find_group, :only => [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(params[:group])

    if @group.errors.any?
      @group.errors.full_messages.each { |message|
        @notice << "#{message.key.to_s} : #{message.value}\n"
      }
    else
      @notice = "Group #{@group.name} has been created"
    end

    redirect_to groups_path, :notice => @notice
  end

  def edit
  end

  def update
    @old_group_name = @group.name

    if @group.update_attributes(params[:group])
      @notice = "Renaming has been finished: '#{@old_group_name}' => '#{@group.name}'"
      redirect_to groups_path, :notice => @notice
    else
      @notice = @group.errors.full_messages.to_s
      redirect_to :action => "edit", :notice => @notice
    end
  end

  def destroy
    @notice = "Group #{@group.name} has been deleted"
    @products = @group.products.each { |p|
      p.destroy
    }
    @group.destroy

    redirect_to groups_path, :notice => @notice
  end

  private

  def find_group
    @group = Group.find(params[:id])
  end

end
