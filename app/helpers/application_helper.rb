# -*- coding: utf-8 -*-
module ApplicationHelper

  def breadcrumbs(arr)
    separator ||= " &raquo; "
    unless arr.blank?
      [].tap do |arr_html|
        arr.each do |options|
          name = options.delete(:name)
          url = options.delete(:href) || "javascript:;"
          arr_html << link_to_unless(options == arr.last, h(name), url, options)
        end
      end.join(separator).html_safe
    end
  end

  def icon_link(icon, body = nil, url_options = {}, html_options = {})
    suffix = body.blank? ? "" : "-text"
    css_class = "link-icon#{suffix} silk_#{icon}"
    body = body.presence || raw('&nbsp;')
    url_options = url_options.presence || "javascript:;"

    html_options = { :class => css_class }.update(html_options)
    link_to(body, url_options, html_options)
  end

  def nl2br(text)
    text.gsub("\n\r","<br />").gsub("\r", "").gsub("\n", "<br />").html_safe rescue ""
  end

  def is_ordered_by?(field)
    order_params[:column].to_sym == field.to_sym
  end

  def order(resource_class, options = {})
    column  = options.delete(:by).to_sym
    caption = options.delete(:as)
    url_params = options.delete(:params)

    if caption
      caption = caption.is_a?(Symbol) ? resource_class.human_attribute_name(caption) : caption
    else
      caption = resource_class.human_attribute_name(column)
    end

    order_column = order_params[:column].to_sym
    order_direction = order_params[:direction].to_sym

    direction = column == order_column && order_direction == :asc ? :desc : :asc

    if column == order_column
      caption = direction == :asc ? "#{h(caption)}&nbsp;&#9660;".html_safe : "#{h(caption)}&nbsp;&#9650;".html_safe
    end

    order_options = { :oc => column, :od => direction, :p => nil }
    url_options = current_location_params.merge(order_options)

    options[:title] = resource_class.human_attribute_name(options[:title]) if options[:title] && options[:title].is_a?(Symbol)

    link_to caption, url_for(url_options), options
  end

end
