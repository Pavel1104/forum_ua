# -*- coding: utf-8 -*-
class BoardsController < ApplicationController
  before_filter :find_parent_item
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]
  before_filter :set_breadcrumbs, :only => :index

  def index
    @boards = Board.all
  end

  def new
    @item = parent_resource_scope.new
  end

  def create
    @item = parent_resource_scope.new(params[:item])
    @success = @item.save
    redirect_to section_board_path(@parent_item) if @success
  end

  def show

  end

  def edit
  end

  def update
    @success = @item.update_attributes(params[:item])
    redirect_to section_board_path(@parent_item)
     # if @success
  end

  def destroy
    @item.destroy
    redirect_to section_path(@parent_item)
  end


  private

  def find_item
    @item = parent_resource_scope.find(params[:id])
  end

  def find_parent_item
    @parent_item = Section.find(params[:section_id])
  end

  def resource_class
    Board
  end
  helper_method :resource_class

  def parent_resource_scope
    @parent_item.boards
  end

  def default_order_params
    [:created_at, :desc]
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << { :name => t("home", :scope => ["common", "title"]), :href => root_path }
    @breadcrumbs << { :name => t("index", :scope => ["sections", "title"]), :href => { :controller => :sections, :action => :index } }
    @breadcrumbs << { :name => @parent_item.title, :href => { :controller => :sections, :action => :edit, :id => @parent_item } }
    @breadcrumbs << { :name => t("index", :scope => [params[:controller], "title"]), :href => { :action => :index } }
  end

end
