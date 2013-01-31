**Rails CRM**
=============

Rails CRM is an opensource Customer Relations Management application.  Intended to be similiar to Paid CRM's, Rails CRM is going to be the bare bones minimum for a CRM but yet can be cloned and modified however you please.

Rails CRM uses Mongoid and Mongodb, Twitter Bootstrap, Devise for authentication, as well as HAML and SASS.  I prefer to use nosql and Mongodb is our favorite.  I looked at a few other opensource CRM's but did not find any that used mongodb.  Rails CRM became a pet project and was a starting point for one of RebelHolds interns Rick Carlino.

There is a live version on Heroku at http://demo.railscrm.com


Mongodb
========

Rails CRM uses Mongodb for its database.  You will need to have it installed to use Rails CRM.  To install mongocrm, checkout the Mongodb installation information at: 
	
		http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/

RVM
===

Rails CRM has a .rvmrc file for specifying the Ruby version.  If you are not using RVM you should.  RVM can be installed at the command line using:

		curl -L https://get.rvm.io | bash -s stable --ruby


Install
=======

	1.  git clone the repository
	2.  cd into rails_crm
	3.  accept the .rvmrc file
	4.  gem install bundler
	5.  bundle install

Start rails server and go to localhost:3000 and you will see the Rails CRM login page.  Just create a user and you are up and running.


Approval Process
================

As the default, all users are automatically approved upon registration.  To change this just edit line 12 of the user model:

	  field :approved, :type => Boolean, :default => true ## change to false


Work Flow
=========

This is the intended workflow:

	1. Create a Lead
	2. Create a Task for a Lead
	3. Convert Lead
		3.1 After qualifying a lead it can be converted to to contact
		3.2 During the conversion process, an Opportunity can be created
	4. Create a Contact 
		4.1 These do NOT have to be a converted lead
	5. Create an Account
		5.1 An account can have many contacts and is generally the Company


The initial setup will require Users to be created.  Once your Organization has Users, it can assign leads, contacts, opportunities and accounts to them.


Web-to-Lead
===========
Thanks to Rahul, Rails CRM now has a web-to-lead function.  With this, you can generate a web-to-lead form to put on your website which will create a new lead in Rails CRM when a visitor submits the form.

When you go to Leads and click on Web-to-Lead it brings up the form generator.  

Redirect URL - This is the page that you want to redirect to after the form is submitted.  This is most likely the "Thank You" page.

Form Creation - Select the fields that you want your form to have.  At this time we do not have the ability to add a custom field so WYSIWYG.  After selecting the fields, click "Generate Form" and this will bring you to the generated form code.  Copy and paste this code on your website.


TODO
====

In addition to the stories in Pivotal Tracker, the following still need to be done:

- Create links to show views
- Add email function to leads/contacts etc (click to email)
-	Add tagging to Leads and Opportuntites.
- Create Import/Export process.
- Create standard reports TBD.
- Make the web-to-lead use the application URL

Ultimately, RailsCRM needs to remain easy to set up and to use and not become bloated like so many other CRM's out there.


Contributing
============

If you make improvements to this application, please share with others.

Send the author a message, create an [issue](https://github.com/brobertsaz/railscrm/issues), or fork the project and submit a pull request.

If you add functionality to this application, create an alternative implementation, or build an application that is similar, please contact me and I’ll add a note to the README so that others can find your work.

This is a work in progress, so if you would like to help out or have suggestions, feel free to contact me at bob@rebel-outpost.com

Licensing
=========

Copyright &copy; 2012 Bob Roberts <bob@rebel-outpost.com>
Distributed under the MIT license.
http://www.opensource.org/licenses/mit-license.php


