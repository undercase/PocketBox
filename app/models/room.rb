class Room < ActiveRecord::Base
  has_many :speeches
  validates :name, presence: true
end
