class ChangeInquiryFormFieldsColumn < ActiveRecord::Migration
  def up
  	change_column :spud_inquiry_form_fields, :options, :text
  end

  def down
  	change_column :spud_inquiry_form_fields, :options, :string
  end
end
