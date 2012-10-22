require 'spec_helper'

describe "traceroutes/new" do
  before(:each) do
    assign(:traceroute, stub_model(Traceroute).as_new_record)
  end

  it "renders new traceroute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => traceroutes_path, :method => "post" do
    end
  end
end
