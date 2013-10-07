class InquirySweeper < ActionController::Caching::Sweeper
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
    if defined? Spud::Cms::Engine #Is CMS Being Used?
      values = [record.name]
      values << @old_name if !@old_name.blank?
      SpudPageLiquidTag.where(:tag_name => "inquiry",:value => values).includes(:attachment).each do |tag|
        partial = tag.attachment
        partial.postprocess_content
        partial.save
        page = nil
        if(partial.attributes.has_key? 'spud_page')
          page = partial.try(:spud_page)
        end
        if page.blank? == false
          page.updated_at = Time.now.utc
          page.save
        end
      end

    end
  end



end
