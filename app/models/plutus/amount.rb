module Plutus
  # The Amount class represents debit and credit amounts in the system.
  #
  # @abstract
  #   An amount must be a subclass as either a debit or a credit to be saved to the database.
  #
  # @author Michael Bulat
  class Amount < ActiveRecord::Base
    belongs_to :entry, :class_name => 'Plutus::Entry'
    belongs_to :account, :class_name => 'Plutus::Account'
    belongs_to :trackable, polymorphic: true, optional: true

    validates_presence_of :type, :amount, :entry, :account
    # attr_accessible :account, :account_name, :amount, :entry

    # Assign an account by name
    def account_name=(name)
      self.account = Account.find_by_name!(name)
    end

    def amount_money
      Money.from_amount amount
    end

    protected
  end
end
