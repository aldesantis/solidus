# frozen_string_literal: true

require 'spec_helper'
require 'solidus/i18n'

RSpec.describe "i18n" do
  before do
    # This reload avoids an issue with I18n.available_locales being cached
    I18n.reload!

    I18n.backend.store_translations(:en,
    {
      spree: {
        i18n: {
          this_file_language: "English"
        },
        foo: "bar",
        bar: {
          foo: "bar within bar scope",
          invalid: nil,
          legacy_translation: "back in the day..."
        },
        invalid: nil,
        legacy_translation: "back in the day..."
      }
    })
  end
  after do
    I18n.reload!
  end

  it "translates within the spree scope" do
    expect(Solidus::Deprecation).to receive(:warn).twice
    expect(Solidus.t(:foo)).to eql("bar")
    expect(Solidus.translate(:foo)).to eql("bar")
  end

  it "prepends a string scope" do
    expect(Solidus::Deprecation).to receive(:warn)
    expect(Solidus.t(:foo, scope: "bar")).to eql("bar within bar scope")
  end

  it "prepends to an array scope" do
    expect(Solidus::Deprecation).to receive(:warn)
    expect(Solidus.t(:foo, scope: ["bar"])).to eql("bar within bar scope")
  end

  it "returns two translations" do
    expect(Solidus::Deprecation).to receive(:warn)
    expect(Solidus.t([:foo, 'bar.foo'])).to eql(["bar", "bar within bar scope"])
  end

  it "returns reasonable string for missing translations" do
    expect(Solidus::Deprecation).to receive(:warn)
    expect(Solidus.t(:missing_entry)).to include("<span")
  end

  it "should have a Solidus::I18N_GENERIC_PLURAL constant" do
    expect(Solidus::I18N_GENERIC_PLURAL).to eq 2.1
  end

  describe "i18n_available_locales" do
    it "should only return :en" do
      expect(Solidus.i18n_available_locales).to eq([:en])
    end

    context 'with unprefixed translations in another locale' do
      before do
        I18n.backend.store_translations(:fr, { cheese: "fromage" })
      end

      it "should only return :en" do
        expect(Solidus.i18n_available_locales).to eq([:en])
      end
    end

    context 'with spree-prefixed translations in another locale' do
      before do
        I18n.backend.store_translations(:fr, spree: { cheese: "fromage" })
      end

      it "should return :en and :fr" do
        expect(Solidus.i18n_available_locales).to eq([:en])
      end
    end

    context 'with specific desired key' do
      before do
        I18n.backend.store_translations(:fr, spree: { i18n: { this_file_language: "Français" } })
      end

      it "should return :en and :fr" do
        expect(Solidus.i18n_available_locales).to eq([:en, :fr])
      end
    end
  end
end
