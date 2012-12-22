FactoryGirl.define do
	sequence :field_name do |n|
	    "Field #{n}"
	end
	factory :spud_inquiry_field do
		name { FactoryGirl.generate(:field_name) }
    spud_inquiry { FactoryGirl.create(:spud_inquiry) }
    value "Test Value"
	end
end
