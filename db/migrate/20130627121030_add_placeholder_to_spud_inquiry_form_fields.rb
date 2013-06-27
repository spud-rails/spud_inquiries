class AddPlaceholderToSpudInquiryFormFields < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_form_fields, :placeholder, :string
  end
end
