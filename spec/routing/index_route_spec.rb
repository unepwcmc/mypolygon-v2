require 'spec_helper'

describe "home routing" do
  it "Routes the root to the home controller's index action" do
    { :get => '/' }.should route_to(controller: 'home', action: 'index')
  end
end
