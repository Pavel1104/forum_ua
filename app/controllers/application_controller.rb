# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :set_page_title,  :only => :index
  helper :all
  protect_from_forgery

  def index
    # :set_page_title
    # @page_title = "Home Forum_ua"
    @breadcrumbs = nil
    render :template => "/shared/home"
  end

  def debug_assets?
    Rails.env.development?
  end
  helper_method :debug_assets?

  def current_location_params(options = {})
    p = request.get? ? Hash.new.update(request.params).symbolize_keys! : {}
    p.update(options)
  end
  helper_method :current_location_params

    private

  # def pagination_params
  #   {
  #     :page => !params[:p].blank? && params[:p].is_a?(String) && params[:p].to_i > 0 ? params[:p].to_i : 1,
  #     :per_page => !params[:pp].blank? && params[:pp].is_a?(String) && params[:pp].to_i > 0 ? params[:pp].to_i : default_per_page
  #   }
  # end
  # helper_method :pagination_params

  def order_params
    {
      :column => !params[:oc].blank? && params[:oc].is_a?(String) && resource_class.column_names.include?(params[:oc]) ? params[:oc].to_sym : default_order_params[0],
      :direction => !params[:od].blank? && params[:od].is_a?(String) && ["asc", "desc"].include?(params[:od].downcase) ? params[:od].to_sym : default_order_params[1]
    }
  end
  helper_method :order_params

  # def default_per_page
  #   20
  # end

  def default_order_params
    [:id, :desc]
  end

  def ready_order_params
    "#{order_params[:column]} #{order_params[:direction]}"
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << { :name => t("home", :scope => ["common", "title"]), :href => root_path }
    @breadcrumbs << { :name => t("index", :scope => [params[:controller], "title"]), :href => { :action => :index } }
  end

  def set_page_title
    @page_title = t(params[:action], :scope => [params[:controller], "title"])
  end


end
