class Country < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :stockists

  def to_s
    name
  end
end
