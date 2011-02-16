require File.expand_path("../../spec_helper", __FILE__)

describe Sova::HTTPError do
  before do
    @response = HTTPI::Response.new(404, {"Content-Type" => "text/plain"}, "Not found")
    @error = Sova::HTTPError.new(@response)
  end

  it "forwards code" do
    @error.code.should == 404
  end

  it "forwards headers" do
    @error.headers.should == {"Content-Type" => "text/plain"}
  end

  it "forwards body" do
    @error.body.should == "Not found"
  end
end
