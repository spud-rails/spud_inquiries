class AddRecipientsToSpudInquiryForms < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_forms, :recipients, :text
    add_column :spud_inquiry_forms, :subject, :string
  end
end
