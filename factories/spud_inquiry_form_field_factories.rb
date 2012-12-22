FactoryGirl.define do
  sequence :form_field_name do |n|
      "Field #{n}"
  end
  factory :spud_inquiry_form_field do
    name { FactoryGirl.generate(:form_field_name) }
    field_type 0
    spud_inquiry_form { FactoryGirl.create(:spud_inquiry_form) }
  end
end
