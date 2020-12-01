require "test_helper"

describe PetsController do
  REQUIRED_PET_FIELDS = ["id", "name", "species", "age", "owner"].sort

  describe 'index' do
    it "responds with JSON and success" do
      get pets_path

      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
    end

    it 'will return all the proper fields for a list of pets' do
      # Act
      get pets_path

      # Get the body of the response as na array or hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array

      body.each do |pet|
        expect(pet).must_be_instance_of Hash
        expect(pet.keys.sort).must_equal REQUIRED_PET_FIELDS
      end
    end

    it 'returns an empty array if no pets exist' do
      Pet.destroy_all

      # Act
      get pets_path

      # Get the body of the response as na array or hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0

    end
  end

  describe 'show' do
    it 'should respond with ok if pet is found' do
      reuben = Pet.find_by(name: "Reuben")

      get pet_path(reuben.id)

      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'

      body = JSON.parse(response.body)
      expect(body.keys.sort).must_equal REQUIRED_PET_FIELDS
      expect(body["id"]).must_equal reuben.id
      expect(body["name"]).must_equal reuben.name
      expect(body["species"]).must_equal reuben.species
      expect(body["age"]).must_equal reuben.age
      expect(body["owner"]).must_equal reuben.owner
    end

    it 'should respond with not_found if no pet matches the id' do
      # Act
      get pet_path(-1)

      body = JSON.parse(response.body)
      must_respond_with :not_found

      # Then you can test for the json in the body of the response
      expect(body["ok"]).must_equal false
      expect(body["errors"]).must_include "Not Found"
    end
  end
end
