# -*- coding: utf-8 -*-
class ThreadsController < ApplicationController

  before_filter :find_parent_item
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]
  before_filter :set_breadcrumbs

  def index
    @threads = Threads.all
  end

  def new
    @item = parent_resource_scope.new
  end

  def create
    @item = parent_resource_scope.new(params[:item])
    @success = @item.save
    redirect_to section_board_thread_path(@parent_item, @item) if @success
  end

  def show
    # @threads = @item.threads
  end

  def edit
  end

  def update
    @success = @item.update_attributes(params[:item])
    # redirect_to section_board_path(@parent_item)
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
    @parent_item = Board.find(params[:board_id])
  end

  def resource_class
    Thread
  end
  helper_method :resource_class

  def parent_resource_scope
    @parent_item.threads
  end

  def default_order_params
    [:created_at, :desc]
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << { :name => t("home", :scope => ["common", "title"]), :href => root_path }
    @breadcrumbs << { :name => t("index", :scope => ["sections", "title"]), :href => { :controller => :sections, :action => :index } }
    @breadcrumbs << { :name => @parent_item.title, :href => { :controller => :sections, :action => :show, :id => @parent_item } }
    @breadcrumbs << { :name => t("index", :scope => [params[:controller], "title"]), :href => { :action => :index } }
  end

end
