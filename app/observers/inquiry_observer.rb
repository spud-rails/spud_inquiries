class InquiryObserver < ActiveRecord::Observer
  observe :spud_inquiry_form,:spud_inquiry_form_field

  def before_save(record)
    if record.is_a?(SpudInquiryForm)
      @old_name = record.name_was
    else
      @old_name = nil
    end
  end

  def after_save(record)
    if record.is_a?(SpudInquiryFormField)
      reset_cms_pages(record.spud_inquiry_form)
    else
      reset_cms_pages(record)
    end
  end
  def after_destroy(record)
    if record.is_a?(SpudInquiryFormField)
      reset_cms_pages(record.spud_inquiry_form)
    else
      reset_cms_pages(record)
    end
  end
private
  def reset_cms_pages(record)
    if defined? Spud::Cms::Engine
      values = [record.name]
      values << @old_name if !@old_name.blank?
      SpudPageLiquidTag.where(:tag_name => "inquiry",:value => values).includes(:spud_page_partial).each do |tag|
        partial = tag.spud_page_partial
        partial.postprocess_content
        partial.save
        partial.spud_page.updated_at = Time.now.utc
        partial.spud_page.save
      end

    end
  end



end
