require_relative '../serializers/bird_serializer'

# Bird Model with Mongoid ORM
class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: Date, default: Date.today
  field :visible, type: Boolean, default: false

  validates :name, presence: true
  validates :family, presence: true
  validates :continents, presence: true
  validate :added_format
  validate :continents_uniqueness

  scope :visible_birds, -> { where(visible: true) }

  private
    # add an error to an object if field 'added' has invalid format
    def added_format
      errors.add(:added, 'Invalid date format. It should be either \'dd-mm-YYYY\', \'YYYY-mm-dd\', \'dd/mm/YYYY\' or \'YYYY/mm/dd\'') unless self.added
    end

    #  add an error to an object if field 'continents' has duplicate values
    def continents_uniqueness
      errors.add(:continents, 'can\'t have duplicate values') if self.continents.present? && self.continents.uniq.length != self.continents.length
    end
end
