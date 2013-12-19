class Field < ActiveRecord::Base
  TYPES = %w{text textarea radio checkbox select}

  attr_accessible :form_id, :label, :field_type, :default, :name, :pos



  # Validations

  validates :field_type, :form, :name, presence: true
  validates :field_type, inclusion: { in: TYPES }
  validates :pos, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :unique_form_field_name



  # Associations

  belongs_to :form, inverse_of: :fields
  has_many :field_options, inverse_of: :field, dependent: :destroy
  has_many :field_data, class_name: "FieldData", inverse_of: :field, dependent: :destroy



  # Class Methods

  def self.types
    TYPES
  end



  # Instance Methods

  def as_json(options = nil)
    super(options.merge(include: :field_options))
  end



  private

    # Custom Validators

    def unique_form_field_name
      return if self.name.blank?
      duplicate = Field.find_by_form_id_and_name(self.form_id, self.name)
      errors.add(:name, "must be unique for form") if duplicate && duplicate.id != self.id
    end
end
