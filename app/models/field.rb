class Field < ActiveRecord::Base
  TYPES = %w{text textarea radio checkbox select}

  attr_accessible :form_id, :label, :type, :default



  # Validations

  validates :type, :form, presence: true
  validates :type, inclusion: { in: TYPES }



  # Associations

  belongs_to :form, inverse_of: :fields



  # Class Methods

  def self.types
    TYPES
  end

end
