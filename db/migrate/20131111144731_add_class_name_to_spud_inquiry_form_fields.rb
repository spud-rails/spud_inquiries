class AddClassNameToSpudInquiryFormFields < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_form_fields, :class_name, :string
  end
end
