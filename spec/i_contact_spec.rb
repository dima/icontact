require 'spec_helper'

describe IContact do
  let(:app_id) { "app_id" }

  before(:each) do
    @config = IContact.configuration
  end

  after(:each) do
    IContact.configuration = @config
  end

  it 'instantiates a configuration' do
    IContact.configure do |config|
      config.app_id = app_id
    end

    expect(IContact.configuration).to be_kind_of(IContact::Configuration)
    expect(IContact.configuration.app_id).to eql(app_id)
  end

  it 'raises an exception if I do not have a valid configuration' do
    IContact.configuration = mock
    IContact.configuration.expects(:valid?).returns(false)
    expect { IContact.connection }.to raise_error(IContact::InvalidConfiguration)
  end

  it 'raises an exception if I do not specify a configuration' do
    IContact.configuration = nil
    expect { IContact.connection }.to raise_error(IContact::InvalidConfiguration)

  end

  it 'includes the account id in the url by default' do
    expect(IContact.url).to match(/#{IContact.configuration.account_id}/)
  end
end

