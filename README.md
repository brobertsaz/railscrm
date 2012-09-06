Rails CRM
===============

Rails CRM is an opensource Customer Relations Management application.  Intended to be similiar to Paid CRM's, Rails CRM is going to be the bare bones minimum for a CRM but yet can be cloned and modified however you please.

Rails CRM uses Mongoid and Mongodb, Twitter Bootstrap, Devise for authentication, as well as HAML and SASS.  I prefer to use nosql and Mongodb is our favorite.  I looked at a few other opensource CRM's but did not find any that used mongodb.  Rails CRM became a pet project and was a starting point for one of RebelHolds interns Rick Carlino.

There are a lot of features that are not yet implemented and I will add them to the Pivotal Tracker https://www.pivotaltracker.com/projects/503421.

There is also a live version on Heroku at http://demo.railscrm.com

This is a work in progress, so if you would like to help out or have suggestions, feel free to contact me at bob@rebel-outpost.com 

Install
=======

    gem install bundler
    bundle install


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




Copyright &copy; 2012 Bob Roberts <bob@rebel-outpost.com>
Distributed under the MIT license.
http://www.opensource.org/licenses/mit-license.php


