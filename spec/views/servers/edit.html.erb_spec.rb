require 'spec_helper'

describe "servers/edit" do
  before(:each) do
    @server = assign(:server, stub_model(Server,
      :ip => "MyText",
      :name => "MyText",
      :country => "MyText",
      :zip => 1,
      :city => "MyText",
      :state => "MyText",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders the edit server form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => servers_path(@server), :method => "post" do
      assert_select "textarea#server_ip", :name => "server[ip]"
      assert_select "textarea#server_name", :name => "server[name]"
      assert_select "textarea#server_country", :name => "server[country]"
      assert_select "input#server_zip", :name => "server[zip]"
      assert_select "textarea#server_city", :name => "server[city]"
      assert_select "textarea#server_state", :name => "server[state]"
      assert_select "input#server_latitude", :name => "server[latitude]"
      assert_select "input#server_longitude", :name => "server[longitude]"
    end
  end
end
