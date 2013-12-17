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



  # Instance Methods

  def next_field_pos
    self.fields.count
  end

  def add_field!(field)
    field.pos = self.next_field_pos
    self.fields << field
    self.save!
  end

  def insert_field!(field, pos)
    # Make room by shifting other fields to the right and save! them
    shift_fields = self.fields.where("pos >= ?", pos).order("pos DESC")
    shift_fields.each do |shift_field|
      shift_field.pos += 1
      shift_field.save!
    end


    # Add new field
    field.pos = pos
    self.fields << field
    self.save!
  end

  def move_field!(pos1, pos2)
    return if pos1 == pos2

    field = Field.find_by_pos(pos1)
    raise ArgumentError.new("Field not found") unless field
    raise ArgumentError.new("New position out of bounds") unless pos2.between?(0, self.fields.count)

    # Move field to temporary position at end of form
    field.pos = self.fields.count
    field.save!


    # Make room by shifting other fields and save! them
    if pos2 > pos1
      min = pos1 + 1
      max = pos2
      dir = -1
      order = "ASC"

    else
      min = pos2
      max = pos1 - 1
      dir = 1
      order = "DESC"
    end

    shift_fields = self.fields.where("pos >= ? AND pos <= ?", min, max).order("pos #{order}")

    shift_fields.each do |shift_field|
      shift_field.pos += dir
      shift_field.save!
    end

    # Move field into final position
    field.pos = pos2
    field.save!
  end

  def as_json(options = nil)
    super(options.merge(include: :fields))
  end
end
