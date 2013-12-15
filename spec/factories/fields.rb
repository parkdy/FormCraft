FactoryGirl.define do
	factory :field do
		field_type "text"
		label "Field:"
		form_id 1

		sequence :name do |n|
			"field_#{n}"
		end

		sequence :pos do |n|
			n
		end

		factory :text_field do
			field_type "text"
			label "Text Field:"
		end

		factory :textarea_field do
			field_type "textarea"
			label "Multi-Line Text Field:"
		end
	end
end