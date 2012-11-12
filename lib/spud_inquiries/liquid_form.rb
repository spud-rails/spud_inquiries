module Spud
  module Inquiries
    class FormActionView < ActionView::Base
       include ActionView::Helpers
       def protect_against_forgery?
        return false
       end
    end

    class InquiryForm < Liquid::Tag
      def initialize(tag_name, form_name, tokens)
        @form_name = form_name
        puts @form_name
        @inquiry_form = SpudInquiryForm.where(:name => form_name).includes(:spud_inquiry_form_fields).first
        @view = FormActionView.new([Rails.application.config.paths["app/views"].first,Spud::Inquiries::Engine.config.paths["app/views"].first])

      end

      def render(context)

        if !@inquiry_form.blank?
          @inquiry = SpudInquiry.new(:spud_inquiry_form_id => @inquiry_form.id)
          @view.render(
            :partial => "/contacts/show",
            :locals => {:inquiry => @inquiry, :inquiry_form => @inquiry_form}
          )
        else
          return ''
        end

      end
    end
  end
end
