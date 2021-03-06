module IContact
  class Subscription
    include IContact::Model

    key_attribute :subscription_id
    attribute :contact_id, :type => Integer
    attribute :list_id, :type => Integer
    attribute :status, :type => String
  end
end
