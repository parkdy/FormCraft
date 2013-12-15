FactoryGirl.define do
	factory :user do
		username "user"
        email "user@example.com"
        password "password"
        password_confirmation "password"

        factory :random_user do
        	sequence :username do
        		Faker::Name.name.downcase.split(' ').join('')
        	end

	        sequence :email do |n|
	        	"random_user_#{n}@example.com"
	        end
        end
    end
end