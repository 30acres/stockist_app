class Location < ActiveRecord::Base

  after_validation :geocode
  geocoded_by :where
  def where
    "#{name}"
  end
end
