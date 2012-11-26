
class MenuItem
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  attr_accessor :children, :link

  def initialize(text, link, level, link_options={})
    @text = text.html_safe? ? text : ERB::Util.html_escape(text)
    @link, @level, @link_options = link, level, link_options
    @children = []
  end

  def add(text, link, link_options={}, &block)
    (MenuItem.new(text, link, @level +1, link_options)).tap do |adding|
      @children << adding
      yield adding if block_given?
    end
  end

  def build
    link_or_span = @link.nil? ? content_tag(:span, @text, @link_options) : link_to(@text, @link, @link_options)
    content_tag(:li, link_or_span + child_output, ({ :class => 'active' } if active?))
  end

  def level_class
    "menu_level_#{@level}"
  end

  def child_output
    children.empty? ? '' : content_tag(:ul, @children.collect(&:build).join.html_safe, :class => level_class)
  end

  def active?
    # FIXME
    # children.any?(&:active?) || on_current_page?
    false
  end

  def on_current_page?
    # FIXME
    # !@controller.nil? && current_page?(@link) if @link
    false
  end

end



class SemanticMenu < MenuItem
  def initialize(options={}, &block)
    @options  = { :class => 'menu' }.merge options
    @level    = 0
    @children = []

    yield self if block_given?
  end

  def build
    content_tag(:ul, @children.collect(&:build).join.html_safe, @options)
  end
end



# Use as so:
# <%= semantic_menu do |root|
#   root.add "overview", root_path
#   root.add "comments", comments_path
# end %>
#
# Assuming you are on /comments, the output would be:
#
# <ul class="menu">
#   <li>
#     <a href="/">overview</a>
#   </li>
#   <li class="active">
#     <a href="/comments">comments</a>
#   </li>
# </ul>

module MenuHelper
  def semantic_menu(options={}, &block)
    SemanticMenu.new(options, &block).build
  end
end

ActionView::Base.send :include, MenuHelper
