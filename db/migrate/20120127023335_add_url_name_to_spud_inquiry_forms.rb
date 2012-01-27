class AddUrlNameToSpudInquiryForms < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_forms, :url_name, :string
    add_index :spud_inquiry_forms,:url_name
  end
end
