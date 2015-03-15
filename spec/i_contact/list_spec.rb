require 'spec_helper'

describe IContact::List, :vcr => true do
  it 'can be created' do
    list = IContact::List.new(:name => "Test List")
    expect(list.save).to be_truthy
    expect(list).to be_persisted
    expect { list.destroy }.not_to raise_error
  end
end

