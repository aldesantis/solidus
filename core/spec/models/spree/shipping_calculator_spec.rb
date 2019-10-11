# frozen_string_literal: true

require 'rails_helper'

module Solidus
  RSpec.describe ShippingCalculator, type: :model do
    let(:line_item1) { build(:line_item, price: 10) }
    let(:line_item2) { build(:line_item, price: 20) }

    let(:inventory_unit1) { build(:inventory_unit, line_item: line_item1) }
    let(:inventory_unit2) { build(:inventory_unit, line_item: line_item2) }

    let(:package) do
      build(
        :stock_package,
        contents: [
          Solidus::Stock::ContentItem.new(inventory_unit1),
          Solidus::Stock::ContentItem.new(inventory_unit1),
          Solidus::Stock::ContentItem.new(inventory_unit2)
        ]
      )
    end

    subject { ShippingCalculator.new }

    it 'computes with a shipment' do
      shipment = mock_model(Solidus::Shipment)
      expect(subject).to receive(:compute_shipment).with(shipment)
      subject.compute(shipment)
    end

    it 'computes with a package' do
      expect(subject).to receive(:compute_package).with(package)
      subject.compute(package)
    end

    it 'compute_shipment must be overridden' do
      expect {
        subject.compute_shipment(shipment)
      }.to raise_error NameError
    end

    it 'compute_package must be overridden' do
      expect {
        subject.compute_package(package)
      }.to raise_error NotImplementedError
    end

    it 'checks availability for a package' do
      expect(subject.available?(package)).to be true
    end

    it 'calculates totals for content_items' do
      expect(subject.send(:total, package.contents)).to eq 40.00
    end
  end
end
