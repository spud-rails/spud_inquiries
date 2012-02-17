Spud Inquiries
==============

Spud Inquiries is a Spud Engine designed to make it easier to generate contact forms and send email notifications when these inquiries occur. This engine works great with the spud_cms engine but it is fully capable of running standalone with spud_core.

Installation/Usage
------------------

1. In your Gemfile add the following

		gem 'spud_core', :git => "git://github.com/davydotcom/spud_core_admin.git"
		gem 'spud_inquiries', :git => "git://github.com/davydotcom/spud_inquiries.git"

2. Run bundle install
3. Copy in database migrations to your new rails project

		bundle exec rake railties:install:migrations
		rake db:migrate

4. run a rails server instance and point your browser to /spud/admin

Routing to the Inquiries Engine
-------------------------------
By default the inquiries gem routes the "/contact" url to the form named "contact". However this and other configuration options can be changed as shown below.


		Spud::Cms.configure do |config|
		    config.default_contact_form = "contact"
			config.base_layout = "application"
			config.from_address = "no-reply@example.org"
		end



Where "contact" is the name of the form you wish to use (downcased,parameterized,hyphenated)

Inquiry will default render to the 'application' layout of your application. You can change this by adjusting the configuration option called "base_layout". More configuration options can be found in the Wiki "Configuration" page.

Creating a Contact Form
-----------------------
Creating a contact form is still fairly new and improvements will be made as time goes on. To create a new form, go to the Inquiries app inside of your spud admin panel. Click the forms button to manage various forms. Here you can set the form name, any content (html safe) you wish to render before the form renders, and add the form fields to the form (Email address is currently at the top of all forms and not adjustable).

