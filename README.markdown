Spud Inquiries
==============
[![Build Status](https://travis-ci.org/spud-rails/spud_inquiries.png?branch=master)](https://travis-ci.org/spud-rails/spud_inquiries)
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

Creating a Contact Form
-----------------------
Creating a contact form is still fairly new and improvements will be made as time goes on. To create a new form, go to the Inquiries app inside of your spud admin panel. Click the forms button to manage various forms. Here you can set the form name, any content (html safe) you wish to render before the form renders, and add the form fields to the form (Email address is currently at the top of all forms and not adjustable).

Routing to the Inquiries Engine
-------------------------------
By default the inquiries gem routes the "/contact" url to the form named "contact". However this and other configuration options can be changed as shown below.


		Spud::Inquiries.configure do |config|
			config.enable_routes = true
		    config.default_contact_form = "contact"
		    config.base_layout = "application"
		    config.from_address = "no-reply@example.org"
		end



Where "contact" is the name of the form you wish to use (downcased,parameterized,hyphenated)

Inquiry will default render to the 'application' layout of your application. You can change this by adjusting the configuration option called "base_layout". More configuration options can be found in the Wiki "Configuration" page.

Injecting Forms into Spud CMS Pages
-----------------------------------
Spud Supports the use of liquid tags to inject dynamic content into pages. In order to inject a contact form into a spud page simply use the following liquid tag in your content:

```html
 {% inquiry Contact %}
```
The above example will inject a form named "Contact" into your content.


Testing
-----------------

Spud uses RSpec for testing. Get the tests running with a few short commands:

1. Create and migrate the databases:

        rake db:create
        rake db:migrate

2. Load the schema in to the test database:

        rake app:db:test:prepare

3. Run the tests with RSpec

        rspec spec

After the tests have completed the current code coverage stats is available by opening ```/coverage/index.html``` in a browser.
