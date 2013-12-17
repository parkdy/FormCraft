# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :field_option do
    field_id 1

    sequence :value do |n|
      "#{n}"
    end

    sequence :label do |n|
      "Option #{n}"
    end
  end
end
