require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views
  before(:each) do
    setup
    @user = User.create!(:username => 'admin1', :email => 'admin1@admin.com', :password => 'admin1', :password_confirmation => 'admin1')
    UserSession.create!(@user)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "edit action should render edit template" do
    get :edit, :id => User.first
    response.should render_template(:edit)
  end
end
