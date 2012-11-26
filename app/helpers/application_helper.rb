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

end
