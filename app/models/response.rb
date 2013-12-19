class Response < ActiveRecord::Base
  attr_accessible :read



  # Validations

  validates :read, inclusion: { in: [true, false] }



  # Associations

  has_many :field_data, class_name: "FieldData", inverse_of: :response, dependent: :destroy

end
