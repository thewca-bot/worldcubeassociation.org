# frozen_string_literal: true
require 'rails_helper'
require 'i18n-spec'

describe "Locale files content" do
  Dir.glob(Rails.root.join('config', 'locales', '*.yml')).each do |locale_file|
    describe locale_file.to_s do
      it { is_expected.to be_parseable }
      it { is_expected.to have_valid_pluralization_keys }
      it { is_expected.to_not have_missing_pluralization_keys }
      it { is_expected.to have_one_top_level_namespace }
      it { is_expected.to_not have_legacy_interpolations }
      it { is_expected.to have_a_valid_locale }
    end
  end
end

describe "Momentjs activation" do
  let(:file_content) { File.read(Rails.root.join('app', 'assets', 'javascripts', 'application.js')) }

  (I18n.available_locales - [:en]).each do |locale|
    context "for #{locale} the app/assets/javascripts/application.js file" do
      it { expect(file_content).to include("//= require moment/#{locale.downcase}.js") }
    end
  end
end
