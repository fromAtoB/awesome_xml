# frozen_string_literal: true

require File.expand_path("../../../lib/awesome_xml.rb", __FILE__)

RSpec.describe AwesomeXML::Float do
  describe '#evaluate' do
    subject { float.evaluate }

    let(:float) { described_class.new(string, options) }
    let(:options) { {} }

    context 'when text is present' do
      context 'and it forms a number' do
        let(:string) { '123.4' }

        it { is_expected.to eq 123.4 }
      end

      context 'and it does not form a number' do
        let(:string) { 'abc' }

        it { is_expected.to eq 0.0 }
      end
    end

    context 'when text is empty' do
      let(:string) { '' }

      context 'and default_empty option is not set' do
        it { is_expected.to eq nil }
      end

      context 'and default_empty option is set' do
        let(:options) { { default_empty: -1.0 } }

        it { is_expected.to eq -1.0 }
      end
    end

    context 'when text is nil' do
      let(:string) { nil }

      context 'and default option is not set' do
        it { is_expected.to eq nil }
      end

      context 'and default option is set' do
        let(:options) { { default: 10.0 } }

        it { is_expected.to eq 10.0 }
      end
    end
  end

  describe '.parsing_type?' do
    subject { described_class.parsing_type? }

    it { is_expected.to be true }
  end
end
