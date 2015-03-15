require 'spec_helper'

describe IContact::Contact, :vcr => true do
  let(:email) { "user@example.com" }

  has_attr :contact_id, Integer
  has_attr :email, String
  has_attr :first_name, String
  has_attr :last_name, String
  has_attr :suffix, String
  has_attr :street, String
  has_attr :street2, String
  has_attr :city, String
  has_attr :state, String
  has_attr :postalCode, String
  has_attr :phone, String
  has_attr :fax, String
  has_attr :business, String

  before do
    IContact.configuration.account_id = IContact::Account.get.first.account_id
    IContact.configuration.client_folder_id = IContact::ClientFolder.get.first.client_folder_id
  end

  it 'allows me to create a contact' do
    contact = IContact::Contact.new(:email => email)
    expect(contact.save).to be_truthy
  end

  it 'allows me to get all the contacts that are unlisted' do
    contacts = IContact::Contact.unlisted
    expect(contacts).not_to be_empty
  end

  it 'handles for when something goes wrong' do
    contact = IContact::Contact.new(:email => nil)
    expect(contact.save).to be_falsey
  end

  it 'destroys a contact' do
    contact = IContact::Contact.unlisted(:email => email).first
    if contact.nil?
      contact = IContact::Contact.new(:email => email).save!
    end
    expect { contact.destroy }.not_to raise_error
  end
end

