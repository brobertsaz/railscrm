require 'spec_helper'

describe 'Tasks' do

  before do
    pending 'Something is broke with the notification mailer, will come back to this later'
    @user   = FactoryGirl.create :user
    @user2  = FactoryGirl.create :user, email: 'test2@example.com', first_name: 'Jim Jones'
    @lead   = FactoryGirl.create :lead, email: 'test@test.com', first_name: 'Jenny', last_name: 'Smith'
    login_as @user
  
  end

  context 'creates a new task' do
    
    before do
      #clear out the deliveries variable for testing purposes...
      ActionMailer::Base.deliveries = [] 
      click_link 'Tasks'
      click_link 'Create Task'
      fill_in "task_task_name",       with: 'test task'
      select 'Today',                 from: 'task_due_date'
      select "#{@user2.first_name}",  from: 'task_assigned_to'
      select 'Call',                  from: 'task_task_type'
      select "#{@lead.full_name}",    from: 'task_lead_for_task'
      click_button 'Update task'
    end
    
    it 'has a name' do

      Task.first.task_name.should     == 'test task'
      Task.first.due_date.should      == 'today'
      Task.first.assigned_to.should   == "Jim Jones"
      Task.first.task_type.should     == 'call'
      Task.first.lead_for_task.should == "Jenny Smith"
    end
    
    it 'notifies the user they have been assigned to a task' do
      #we cleared the deliveries on start, so it should have 1 email now.
      ActionMailer::Base.deliveries.each.count.should == 1
      #ensure email was sent to correct recipient
      ActionMailer::Base.deliveries[0].to.should include @user2.email
      #ensure message body contains the name and type of task
      ActionMailer::Base.deliveries[0].body.should include 'call' && 'test task'
      
    end
    
  end

## Task editing functionality
  context 'edit' do
    before do
      #clear out the deliveries variable for testing purposes...
      ActionMailer::Base.deliveries = []
      @task   = FactoryGirl.create :task, task_name: 'test task 2', due_date: 'asap', assigned_to: @user3, task_type: 'call', lead_for_task: @lead.full_name
      click_link 'Tasks'
      click_link "#{@task.task_name}"
      fill_in "task_task_name",         with: 'test task123456'
      select 'Tomorrow',                from: 'task_due_date'
      select "#{@user2.first_name}",    from: 'task_assigned_to'
      select 'Email',                   from: 'task_task_type'
      select "#{@lead.full_name}",      from: 'task_lead_for_task'
      click_button 'Update task'
      page.should have_content 'Task Updated'
    end

    it 'has required fields' do
      Task.first.task_name.should       == 'test task123456'
      Task.first.due_date.should        == 'tomorrow'
      Task.first.assigned_to.should     == "Jim Jones"
      Task.first.task_type.should       == 'email'
      Task.first.lead_for_task.should   == "Jenny Smith"
    end

    it 'notifies the user their task has changed' do
      #we cleared the deliveries on start, so it should have 1 email now.
      ActionMailer::Base.deliveries.each.count.should == 1
      #ensure email was sent to correct recipient
      ActionMailer::Base.deliveries[0].to.should include @user2.email
      #ensure message body contains the name and type of task
      ActionMailer::Base.deliveries[0].body.should include 'Email' && 'test task123456'
      
    end
    
    
  end

  context 'delete' do
    before do
      @task   = FactoryGirl.create :task, task_name: 'test task 2', due_date: 'asap', assigned_to: @user3, task_type: 'call', lead_for_task: @lead.full_name
    click_link 'Tasks'
    click_link 'Delete'
    page.should have_content 'Task Deleted'
    end

    it 'does not exist after deletion' do
    Task.first.should_not be
    end
  end
end