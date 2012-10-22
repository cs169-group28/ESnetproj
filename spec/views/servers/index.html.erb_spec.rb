require 'spec_helper'

describe "servers/index" do
  before(:each) do
    assign(:servers, [
      stub_model(Server,
        :ip => "MyText",
        :name => "MyText",
        :country => "MyText",
        :zip => 1,
        :city => "MyText",
        :state => "MyText",
        :latitude => 1.5,
        :longitude => 1.5
      ),
      stub_model(Server,
        :ip => "MyText",
        :name => "MyText",
        :country => "MyText",
        :zip => 1,
        :city => "MyText",
        :state => "MyText",
        :latitude => 1.5,
        :longitude => 1.5
      )
    ])
  end

  it "renders a list of servers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ip", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
