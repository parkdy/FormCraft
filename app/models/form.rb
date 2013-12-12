class Form < ActiveRecord::Base
  attr_accessible :author_id, :description, :title

  validates :title, :author, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :forms
  )
end
