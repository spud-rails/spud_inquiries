class AddValidationToInquiryFields < ActiveRecord::Migration
  def change
    add_column :inquiry_fields, :validation_rule, :string
    add_column :inquiry_fields, :validation_error_message, :string
  end
end
