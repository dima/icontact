require 'spec_helper'

describe IContact::ClientFolder, :vcr => true do
  before do
    IContact.configuration.account_id = IContact::Account.get.first.account_id
    IContact.configuration.client_folder_id = IContact::ClientFolder.get.first.client_folder_id
  end

  it 'returns a valid contact folder' do
    folder = IContact::ClientFolder.get.first
    expect(folder.client_folder_id).to eql(IContact.configuration.client_folder_id)
  end
end
