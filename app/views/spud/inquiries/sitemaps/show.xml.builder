
xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'

# create the urlset
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @forms.each do |form|
    xml.url do
      if form.url_name == Spud::Inquiries.default_contact_form
        xml.loc contact_url()
      else
        xml.loc contact_url(:id => form.url_name)
      end
      xml.lastmod form.updated_at.strftime('%Y-%m-%d')
    end
  end
end