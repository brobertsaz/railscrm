Rails CRM
===============

Rails CRM is an opensource Customer Relations Management application.  Intended to be similiar to Paid CRM's, Rails CRM is going to be the bare bones minimum for a CRM but yet can be cloned and modified however you please.

Rails CRM uses Mongoid and Mongodb, Twitter Bootstrap, Devise for authentication, as well as HAML and SASS.  I prefer to use nosql and Mongodb is our favorite.  I looked at a few other opensource CRM's but did not find any that used mongodb.  Rails CRM became a pet project and was a starting point for one of RebelHolds interns Rick Carlino.

There are a lot of features that are not yet implemented and I will add them to the Pivotal Tracker https://www.pivotaltracker.com/projects/503421.

There is also a live version on Heroku at http://demo.railscrm.com


Mongodb
=======

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


TODO
====

In addition to the stories in Pivotal Tracker, the following still need to be done:

	1. Create User dashboard
		1.1 This will include views for user's leads and tasks.  Leads assigned to user needs to be sortable by several fields such as Name, Company, Status, Date Created, etc.  
		1.2 A sidebar on the dashboard for quick create links for lead, task, contact.	The side bar should also have a search field for searching all all of the categories.
	2.	Add tagging to Leads and Opportuntites.
	3.  Create Import/Export process.
	4.	Create standard reports TBD.

Ultimately, RailsCRM needs to remain easy to set up and to use and not become blaoted like so many other CRM's out there.


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


