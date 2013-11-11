class AddFieldNameToSpudInquiryFormFields < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_form_fields, :field_name, :string
  end
end
