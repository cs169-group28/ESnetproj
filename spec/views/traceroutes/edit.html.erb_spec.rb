require 'spec_helper'

describe "traceroutes/edit" do
  before(:each) do
    @traceroute = assign(:traceroute, stub_model(Traceroute))
  end

  it "renders the edit traceroute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => traceroutes_path(@traceroute), :method => "post" do
    end
  end
end
