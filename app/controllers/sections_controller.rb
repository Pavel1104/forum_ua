# -*- coding: utf-8 -*-
class SectionsController < ApplicationController
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]
  before_filter :set_breadcrumbs

  def index
    @sections = Section.all
  end

  def new
    @item = resource_class.new
  end

  def create
    @item = resource_class.new(params[:item])
    @success = @item.save
    redirect_to Section
  end

  def show
    @boards = @item.boards
  end

  def edit
  end

  def update
    @success = @item.update_attributes(params[:item])
    redirect_to Section
  end

  def destroy
    @item.destroy
    redirect_to Section
  end


  private

  def find_item
    @item = resource_class.find(params[:id])
  end

  def resource_class
    Section
  end
  helper_method :resource_class

  def default_order_params
    [:created_at, :desc]
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << { :name => t("home", :scope => ["common", "title"]), :href => root_path }
    @breadcrumbs << { :name => t("index", :scope => [params[:controller], "title"]), :href => sections_path }
    @breadcrumbs << { :name => @item.title, :href => section_path(@item) } if @item
  end

end
