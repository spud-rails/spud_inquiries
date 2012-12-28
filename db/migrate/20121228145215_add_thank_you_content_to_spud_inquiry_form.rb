class AddThankYouContentToSpudInquiryForm < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_forms, :thank_you_content, :text
  end
end
