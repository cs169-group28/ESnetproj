require 'spec_helper'

describe "traceroutes/show" do
  before(:each) do
    @traceroute = assign(:traceroute, stub_model(Traceroute))
  end

  it "renders attributes in <p>" do
    render
  end
end
