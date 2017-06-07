# frozen_string_literal: true

require File.expand_path("../../../lib/awesome_xml.rb", __FILE__)

RSpec.describe AwesomeXML::Text do
  describe '#evaluate' do
    subject { text.evaluate }

    let(:text) { described_class.new(string, options) }
    let(:options) { {} }

    context 'when text is present' do
      let(:string) { 'TExT' }

      it { is_expected.to eq 'TExT' }
    end

    context 'when text is empty' do
      let(:string) { '' }

      context 'and default_empty option is not set' do
        it { is_expected.to eq '' }
      end

      context 'and default_empty option is set' do
        let(:options) { { default_empty: 'default' } }

        it { is_expected.to eq 'default' }
      end
    end

    context 'when text is nil' do
      let(:string) { nil }

      context 'and default option is not set' do
        it { is_expected.to eq nil }
      end

      context 'and default option is set' do
        let(:options) { { default: '' } }

        it { is_expected.to eq '' }
      end
    end
  end

  describe '.parsing_type?' do
    subject { described_class.parsing_type? }

    it { is_expected.to be true }
  end
end
