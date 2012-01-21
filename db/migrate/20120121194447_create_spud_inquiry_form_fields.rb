class CreateSpudInquiryFormFields < ActiveRecord::Migration
  def change
    create_table :spud_inquiry_form_fields do |t|
      t.integer :spud_inquiry_form_id
      t.string :field_type
      t.string :name
      t.string :options
      t.string :default_value
      t.timestamps
    end
  end
end
