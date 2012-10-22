require 'spec_helper'

describe "traceroutes/index" do
  before(:each) do
    assign(:traceroutes, [
      stub_model(Traceroute),
      stub_model(Traceroute)
    ])
  end

  it "renders a list of traceroutes" do
    render
  end
end
