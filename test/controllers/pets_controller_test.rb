require "test_helper"

describe PetsController do
  describe 'index' do
    it "responds with JSON and success" do
      get pets_path

      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
    end
  end

end
