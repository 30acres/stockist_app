class Stockist < ActiveRecord::Base
  belongs_to :country
  after_validation :geocode #, if: ->(obj){ obj.address.present? and obj.address.changed? }
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  geocoded_by :address

  scope :mapped, -> { where('longitude IS NOT NULL') }

  def self.search(query)
    open_query = "%#{query.downcase}%"
    terms = %w( street_address name city country )
    mapped_terms = terms.map{ |term| "LOWER(" + term + ") like ?"}.join(' OR ')
    where(mapped_terms, open_query, open_query, open_query, open_query)
  end

  def to_s
    name.html_safe
  end

  def address
    [street_address, city, state, country].compact.join(', ')
  end

  def is_mapped?
    longitude != nil
  end

  def map_description
    "<div class='stockist_description'><strong>#{name}</strong><br/>#{address}</br/><a href=\'/stockists/#{slug}\'>Details</a></div>"
  end


end
