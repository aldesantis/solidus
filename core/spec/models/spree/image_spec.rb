# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spree::Image, type: :model do
  it_behaves_like 'an attachment' do
    subject { create(:image) }
    let(:attachment_name) { :attachment }
    let(:default_style) { :product }
  end

  describe 'attachment details' do
    let(:image_file) { File.open(File.join('lib', 'spree', 'testing_support', 'fixtures', 'blank.jpg')) }
    subject { create(:image, attachment: image_file) }

    it 'returns if attachment is present' do
      expect(subject.attachment_present?).to be_truthy
    end

    it 'returns attachment filename' do
      expect(subject.filename).to end_with('blank.jpg')
    end

    it 'returns attachment url' do
      expect(subject.url(:product)).to include('blank.jpg')
    end

    it 'computes attachment width' do
      expect(subject.attachment_width).to eq(1)
    end

    it 'computes attachment height' do
      expect(subject.attachment_height).to eq(1)
    end
  end
end
