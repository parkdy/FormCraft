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

  has_many :fields, inverse_of: :form, dependent: :destroy
  has_many :responses, inverse_of: :form, dependent: :destroy



  # Instance Methods

  def next_field_pos
    self.fields.count
  end

  def add_field!(field)
    field.pos = self.next_field_pos
    self.fields << field
    self.save!
  end

  # #as_json
  # Converts model to Backbone ready JSON
  def as_json(options = nil)
    super(options.merge(include: {fields: {include: [:field_options]}}))
  end

  # #responses_csv
  # Convert form's responses to CSV format
  def responses_csv(options = {})
    CSV.generate(options) do |csv|
      # Add header row
      response_attribute_names = ["status", "submitted"]
      field_names = self.fields.order(:pos).map(&:name)

      header_row = response_attribute_names + field_names
      csv << header_row

      # Add response rows in reverse chronological order
      self.responses.order(:created_at).each do |response|
        row = [
          (response.read ? "read" : "unread"), # status
          response.created_at.to_date # submitted
        ]

        self.fields.order(:pos).each do |field|
          row << response.field_data.find_by_field_id(field.id).value
        end

        csv << row
      end
    end
  end
end
