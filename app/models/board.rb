class Board < ActiveRecord::Base
  self.table_name = "boards"
  attr_accessible :title

  belongs_to :section, :class_name => "Section", :foreign_key => :sid
  has_many :threads,  :class_name => "Thread",  :foreign_key => :bid, :dependent => :destroy

  validates :title,
    :presence => true


  FIELDS_FOR_LIST = [
    :id,
    :title,
    :created_at,
    :updated_at,
  ].freeze

end
