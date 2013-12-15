FactoryGirl.define do
	factory :form do
		title "Untitled Form"
		description "This is an untitled form."
		author_id 1

		factory :random_form do
			sequence :title do |n|
				"Form #{n}"
			end

			sequence :description do |n|
				Faker::Lorem.paragraph
			end
		end
	end
end