# -*- coding: utf-8 -*-
class SectionsController < ApplicationController
  before_filter :set_breadcrumbs, :only => :index
  # before_filter :find_item, :only => [:show, :edit, :update, :destroy]
  # before_filter :set_page_title,  :only => :index

  def index
    @fields = resource_class::FIELDS_FOR_LIST.dup
    @collection = resource_class.
    search(params).
    order(ready_order_params)
  end

  def new
    @item = resource_class.new
  end

  def create
    @item = resource_class.new(params[:item])
    @success = @item.save
  end

  def show
  end

  def edit
  end

  def update
    @success = @item.update_attributes(params[:item])
  end

  def destroy
    @item.destroy
  end

  def destroy_selected
    @items = resource_class.where(:id => params[:id])
    @items.each(&:destroy)
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

end
