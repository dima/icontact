require 'spec_helper'

describe IContact::Account, :vcr => true do
  it 'allows me to fetch my account details' do
    account = IContact::Account.get.first
    expect(account.account_id).not_to be_nil
  end
end

