FactoryGirl.define do
	sequence :form_name do |n|
	    "Form #{n}"
	end
	factory :spud_inquiry_form do
		name { FactoryGirl.generate(:form_name) }
	end
end
