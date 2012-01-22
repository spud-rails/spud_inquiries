class AddFieldOrderToSpudInquiryFormFields < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_form_fields, :field_order, :integer
    add_column :spud_inquiry_form_fields, :required, :boolean
    add_index :spud_inquiry_form_fields,:field_order
  end
end
