class AddFieldNameToSpudInquiryFields < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_fields, :field_name, :string
  end
end
