# -*- coding: utf-8 -*-
class Section < ActiveRecord::Base
  self.table_name = "sections"
  attr_accessible :title

  has_many :boards,  :class_name => "Board",  :foreign_key => :sid, :dependent => :destroy

  validates :title,
    :presence => true,
    :uniqueness => true

  FIELDS_FOR_LIST = [
    :id,
    :title
  ].freeze

end
