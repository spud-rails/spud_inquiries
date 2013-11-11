class AddSubmitTitleToSpudInquiryForm < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_forms, :submit_title, :string
  end
end
