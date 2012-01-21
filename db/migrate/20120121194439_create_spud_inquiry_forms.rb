class CreateSpudInquiryForms < ActiveRecord::Migration
  def change
    create_table :spud_inquiry_forms do |t|
      t.string :name
      t.text :content
      t.timestamps
    end
  end
end
