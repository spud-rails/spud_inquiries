class AddValidationToInquiryFormFields < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_form_fields, :validation_rule, :string
    add_column :spud_inquiry_form_fields, :validation_error_message, :string
  end
end
