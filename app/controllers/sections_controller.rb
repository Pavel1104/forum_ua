# -*- coding: utf-8 -*-
class SectionsController < ApplicationController
  before_filter :set_breadcrumbs
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]

  def index
    @fields = resource_class::FIELDS_FOR_LIST.dup
    @collection = resource_class.
    order(ready_order_params)
    @sections = Section.all
  end

  def new
    @item = resource_class.new
  end

  def create
    @item = resource_class.new(params[:item])
    @success = @item.save
    redirect_to Section if @success
  end

  def show
    @boards = @item.boards
  end

  def edit
  end

  def update
    @success = @item.update_attributes(params[:item])
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

end
