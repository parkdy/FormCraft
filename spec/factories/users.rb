FactoryGirl.define do
	factory :user do
		username "user"
        email "user@formcraft.org"
        password "password"
        password_confirmation "password"

        factory :random_user do
        	sequence :username do
        		Faker::Name.name.downcase.split(' ').join('')
        	end

	        sequence :email do |n|
	        	"random_user_#{n}@formcraft.org"
	        end
        end
    end
end