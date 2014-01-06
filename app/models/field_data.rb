class FieldData < ActiveRecord::Base
  attr_accessible :field_id, :response_id, :value



  # Validations

  validates :field, :response, presence: true



  # Associations

  belongs_to :field, inverse_of: :field_data
  belongs_to :response, inverse_of: :field_data
end
