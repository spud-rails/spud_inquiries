class AddSpudInquiryFormIdToSpudInquiries < ActiveRecord::Migration
  def change
    add_column :spud_inquiries, :spud_inquiry_form_id, :integer
    add_column :spud_inquiries, :recipients, :text
    add_column :spud_inquiries, :subject,:string
    add_column :spud_inquiries, :marked_as_read,:boolean,:default => false

    add_index :spud_inquiries, :marked_as_read
    add_index :spud_inquiries, :spud_inquiry_form_id
  end
end
