class Stockist < ActiveRecord::Base
  belongs_to :country
  ##after_create :geocode #, if: ->(obj){ obj.address.present? and obj.address.changed }
  after_validation :geocode #, if: ->(obj){ obj.address.present? and obj.address.changed }

  validates_presence_of :name
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  geocoded_by :address

  scope :mapped, -> { where('longitude IS NOT NULL') }
  scope :active, -> { where('status <= ?', 2)}
  scope :standby, -> { where('status = ?', 2)}
  scope :in_active, -> { where('status = ?', 3)}

  def self.search(query)
    open_query = "%#{query.downcase}%"
    terms = %w( street_address name city country postcode )
    mapped_terms = terms.map{ |term| "LOWER(" + term + ") like ?"}.join(' OR ')
    where(mapped_terms, open_query, open_query, open_query, open_query, open_query)
  end

  def to_s
    name
  end

  def address
    binding.pry
    [street_address.to_s.titleize.gsub(', ','/'), city.to_s.titleize.gsub(',',' ').strip, state.to_s.upcase, country.to_s.titleize].compact.map{|e| e.to_s }.join(', ')
  end

  def is_mapped?
    slongitude != nil
  end

  def map_description
    "<div class='stockist_description'><strong>#{name}</strong><br/>#{address}</br/><a href=\'/stockists/#{slug}\'>Details</a></div>"
  end

 def slongitude
  unless customlongitude
    longitude
  else
    customlongitude
  end
 end

  def slatitude
  unless customlatitude
    latitude
  else
    customlatitude
  end
 end

 def stockist_is_active?
  status <= 2
 end

end
