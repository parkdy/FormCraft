class Response < ActiveRecord::Base
  attr_accessible :read, :form_id



  # Validations

  validates :form, presence: true
  validates :read, inclusion: { in: [true, false] }



  # Associations

  has_many :field_data, class_name: "FieldData", inverse_of: :response, dependent: :destroy
  belongs_to :form, inverse_of: :responses

end
