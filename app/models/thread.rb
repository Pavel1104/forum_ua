class Thread < ActiveRecord::Base
  self.table_name = "threads"
  attr_accessible :title

  belongs_to :board, :class_name => "Board", :foreign_key => :bid

  validates :title,
    :presence => true


  FIELDS_FOR_LIST = [
    :id,
    :title,
    :created_at,
    :updated_at,
  ].freeze

end
