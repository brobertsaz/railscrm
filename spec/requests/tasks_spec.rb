require 'spec_helper'

describe 'Tasks' do

  before do
    @user   = FactoryGirl.create :user
    @user2  = FactoryGirl.create :user, email: 'test2@example.com', first_name: 'Jim'
    @lead   = FactoryGirl.create :lead, email: 'test@test.com', first_name: 'Jenny', last_name: 'Smith'
    login_as @user
  end

  it 'creates a new task' do
    click_link 'Tasks'
    click_link 'Create Task'
    fill_in "task_task_name",       with: 'test task'
    select 'Today',                 from: 'task_due_date'
    select "#{@user2.email}",       from: 'task_assigned_to'
    select 'Call',                  from: 'task_task_type'
    select "#{@lead.email}",        from: 'task_lead_for_task'
    click_button 'Create Task'
    page.should have_content 'Task Created'
    Task.count.should == 1
  end
    
  it 'has required fields' do
    click_link 'Tasks'
    click_link 'Create Task'
    select 'Today',                 from: 'task_due_date'
    select "#{@user2.email}",       from: 'task_assigned_to'
    select 'Call',                  from: 'task_task_type'
    select "#{@lead.email}",        from: 'task_lead_for_task'
    click_button 'Create Task'
    page.should have_content "can't be blank"
    page.should_not have_content 'Task Updated'
    Task.count.should == 0
  end
    
  it 'notifies the user they have been assigned to a task' do
    click_link 'Tasks'
    click_link 'Create Task'
    fill_in "task_task_name",       with: 'another test task'
    select 'Today',                 from: 'task_due_date'
    select "#{@user2.email}",       from: 'task_assigned_to'
    select 'Call',                  from: 'task_task_type'
    select "#{@lead.email}",        from: 'task_lead_for_task'
    click_button 'Create Task'
    ActionMailer::Base.deliveries.each.count.should == 2
    ActionMailer::Base.deliveries[0].to.should include @user2.email
    ActionMailer::Base.deliveries[0].body.should include 'call' && @lead.email
  end

  context 'edit' do
    before do
      @task = FactoryGirl.create :task, lead_for_task: @lead.first_name
    end

    it 'edits task' do
      click_link 'Tasks'
      click_link "Edit"
      fill_in "task_task_name",         with: 'test task 2 updated'
      select 'Tomorrow',                from: 'task_due_date'
      select "#{@user2.email}",         from: 'task_assigned_to'
      select 'Email',                   from: 'task_task_type'
      select "#{@lead.email}",          from: 'task_lead_for_task'
      click_button 'Update Task'
      page.should have_content 'Task Updated'
      @task.reload
      @task.task_name.should == 'test task 2 updated'
    end


    it 'notifies the user their task has changed' do
      click_link 'Tasks'
      click_link "Edit"
      fill_in "task_task_name",         with: 'test task 2 updated'
      select 'Tomorrow',                from: 'task_due_date'
      select "#{@user2.email}",         from: 'task_assigned_to'
      select 'Email',                   from: 'task_task_type'
      select "#{@lead.email}",          from: 'task_lead_for_task'
      click_button 'Update Task'

      ActionMailer::Base.deliveries.last.to.should include @user2.email
      ActionMailer::Base.deliveries.last.body.should include 'test task 2 updated' && @lead.email
    end
        
  end

  context 'delete' do
    before do
      @task   = FactoryGirl.create :task, lead_for_task: @lead.first_name
    end

    it 'deletes task' do  
      click_link 'Tasks'
      click_link 'Delete'
      page.should have_content 'Task Deleted'
    end

  end
end