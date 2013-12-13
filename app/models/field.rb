class Field < ActiveRecord::Base
  TYPES = %w{text textarea radio checkbox select}

  attr_accessible :form_id, :label, :type, :default, :name



  # Validations

  validates :type, :form, :name, presence: true
  validates :type, inclusion: { in: TYPES }
  validate :unique_form_field_name



  # Associations

  belongs_to :form, inverse_of: :fields



  # Class Methods

  def self.types
    TYPES
  end



  # Helper methdos

  private

    # Custom Validators

    def unique_form_field_name
      form = self.form_id ? Form.find(self.form_id) : nil
      form_fields = (form ? form.fields.includes(:name) : [])

      if form_fields.any? { |field| !self.name.blank? && field.name == self.name }
        errors.add(name: "Field name must be unique for form")
      end
    end

end
