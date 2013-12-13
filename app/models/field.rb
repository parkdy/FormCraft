class Field < ActiveRecord::Base
  TYPES = %w{text textarea radio checkbox select}

  attr_accessible :form_id, :label, :field_type, :default, :name



  # Validations

  validates :field_type, :form, :name, presence: true
  validates :field_type, inclusion: { in: TYPES }
  validate :unique_form_field_name



  # Associations

  belongs_to :form, inverse_of: :fields



  # Class Methods

  def self.types
    TYPES
  end



  private

    # Custom Validators

    def unique_form_field_name
      return if self.name.blank?
      duplicate = Field.find_by_form_id_and_name(self.form_id, self.name)
      if duplicate
        errors.add(:name, "Field name must be unique for form")
      end
    end

end
