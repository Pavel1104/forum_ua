# -*- coding: utf-8 -*-
class Section < ActiveRecord::Base
  self.table_name = "Sections"
  attr_accessible :title
  has_many :borads,  :class_name => "Borads",  :foreign_key => :sid, :dependent => :destroy
  validates :name,
    :presence => true

  def self.search(params)
    s = scoped
    params[:search] = nil unless params[:search].is_a?(String)
    if params[:search]
      q = []
      self::FIELDS_FOR_SEARCH.each { |field| q << "#{field} LIKE :q" }
      s = s.where([q.join(" OR "), { :q => "%#{params[:search]}%" }])
    end
    s
  end

  FIELDS_FOR_LIST = [
    :id,
    :title,
    :created_at,
    :updated_at,
  ].freeze

  FIELDS_FOR_SEARCH = [
    :id,
    :title,
  ].freeze

end
