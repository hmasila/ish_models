
class ::Gameui::Map
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :markers, :class_name => '::Gameui::Marker', inverse_of: :map
  has_many :newsitems, inverse_of: :map

  field :slug
  validates :slug, uniqueness: true, presence: true
  field :parent_slug
  def name
    slug
  end

  field :w, type: Integer
  validates :w, presence: true

  field :h, type: Integer
  validates :h, presence: true

  field :description

  field :img_path

  ORDERING_TYPE_ALPHABETIC = 'alphabetic'
  ORDERING_TYPE_CUSTOM     = 'custom'
  ORDERING_TYPE_TIMESTAMP  = 'timestamp'
  ORDERING_TYPES = [ ORDERING_TYPE_ALPHABETIC, ORDERING_TYPE_CUSTOM, ORDERING_TYPE_TIMESTAMP ]
  field :ordering_type, type: String, default: 'custom' # timestamp, alphabetic, custom
  validates :ordering_type, presence: true

  def self.list conditions = { is_trash: false }
    out = self.order_by( created_at: :desc )
    [['', nil]] + out.map { |item| [ "#{item.created_at.strftime('%Y%m%d')} #{item.name}", item.id ] }
  end

end
