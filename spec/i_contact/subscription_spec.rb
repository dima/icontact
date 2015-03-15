require 'spec_helper'

describe IContact::Subscription, :vcr => true do
  let(:email) { "subscriber@example.com" }

  let(:contact) do
    c = IContact::Contact.new(:email => email)
    c.save
    c
  end

  let(:list) do
    l = IContact::List.new(:name => "Test Subscription List")
    l.save
    l
  end

  before do
    IContact.configuration.account_id = IContact::Account.get.first.account_id
    IContact.configuration.client_folder_id = IContact::ClientFolder.get.first.client_folder_id
  end

  after(:each) do
    contact.destroy
    list.destroy
  end

  it 'allows me to add a list subscription for a given contact' do
    sub = IContact::Subscription.new({
      :contact_id => contact.contact_id,
      :list_id => list.list_id,
      :status => 'normal'
    });

    expect(sub.save).to be_truthy
  end
end

