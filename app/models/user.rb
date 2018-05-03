class User < ApplicationRecord
  has_many :submissions, dependent: :destroy

  validates_presence_of :name
end
