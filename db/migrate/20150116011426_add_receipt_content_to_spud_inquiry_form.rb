class AddReceiptContentToSpudInquiryForm < ActiveRecord::Migration
  def change
    add_column :spud_inquiry_forms, :receipt_content, :text
  end
end
