# frozen_string_literal: true

require 'rails_helper'

module Solidus
  RSpec.describe Reimbursement::Credit, type: :model do
    context 'class methods' do
      describe '.total_amount_reimbursed_for' do
        subject { Solidus::Reimbursement::Credit.total_amount_reimbursed_for(reimbursement) }

        let(:reimbursement) { create(:reimbursement) }
        let(:credit_double) { double(amount: 99.99) }

        before { allow(reimbursement).to receive(:credits).and_return([credit_double, credit_double]) }

        it 'should sum the amounts of all of the reimbursements credits' do
          expect(subject).to eq BigDecimal('199.98')
        end
      end
    end

    describe '#description' do
      let(:credit) { Solidus::Reimbursement::Credit.new(amount: 100, creditable: mock_model(Solidus::PaymentMethod::Check)) }

      it "should be the creditable's class name" do
        expect(credit.description).to eq 'Check'
      end
    end

    describe '#display_amount' do
      let(:credit) { Solidus::Reimbursement::Credit.new(amount: 100) }

      it 'should be a money object' do
        expect(credit.display_amount).to eq Solidus::Money.new(100, currency: "USD")
      end
    end
  end
end
