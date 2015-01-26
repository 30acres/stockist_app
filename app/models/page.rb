class Page < ActiveRecord::Base
  enum status: [ :offline, :online, :hidden ]
  enum content_type: [ :default_content, :html_content, :redcloth_content ]
  has_ancestry

  has_and_belongs_to_many :blocks

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates_uniqueness_of :slug, :title
  validates_presence_of :slug

  default_scope { order(position: :asc) }

  mount_uploader :image, ImageUploader

  def to_s
    title
  end

  def self.search(q)
      Page.online.queried(q)
  end

  def self.queried(q)
    t = Page.arel_table
    results = Page.where(
      t[:title].matches("%#{q}%").
      or(t[:content].matches("%#{q}%"))
    )
  end

end

