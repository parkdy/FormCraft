class Form < ActiveRecord::Base
  attr_accessible :author_id, :description, :title



  # Validations

  validates :title, :author, presence: true



  # Associations

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :forms
  )

  has_many :fields, inverse_of: :form
end
