class FieldOption < ActiveRecord::Base
  attr_accessible :field_id, :label, :value



  # Associations

  belongs_to :field, inverse_of: :field_options



  # Validations

  validates :field, :label, :value, presence: true
end
