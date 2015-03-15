require 'spec_helper'

describe IContact::Model do
  class TestModel
    include IContact::Model

    key_attribute :test_model_id
    attribute :email, :type => String
  end

  let(:email) { 'user@example.com' }
  let(:model) { TestModel.new(:email => email) }

  it 'has a getter and setter for a declared model' do
    new_email = 'another_user@example.com'
    expect(model.email).to eql(email)
    model.email = new_email
    expect(model.email).to eql(new_email)
  end

  it 'defaults to a resource name a demodulized version of the class name' do
    expect(model.class.resource_name).to eql('testmodel')
  end

  it 'uses the IContact http connection' do
    expect(TestModel.connection).to eql(IContact.connection)
  end

  it 'is persisted if the key attribute is populated' do
    model.test_model_id = 1234
    expect(model).to be_persisted

    model.test_model_id = nil
    model.attributes = { :test_model_id => 1234 }
    expect(model.test_model_id).not_to be_nil
  end

  it 'appropriately parses json when an array is specified' do
    mock_resp = mock
    mock_resp.stubs(:valid?).returns(false)
    mock_resp.stubs(:body).returns({:testmodels => [{:email => email}]}.to_json)
    mock_resp.stubs(:status).returns(200)
    result = model.class.parse(mock_resp)
    expect(result.size).to eql(1)
    expect(result.first.email).to eql(email)
  end
end

