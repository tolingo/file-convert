require 'spec_helper'

RSpec.describe FileConvert::Conversion do
  let(:original_file) { double 'file', data: :data }
  let(:file) { FileConvert::File.new original_file }
  subject { file }

  describe '#initialize' do
    it { is_expected.to be_a FileConvert::File }
  end

  describe '#data' do
    subject { file.data }
    it { is_expected.to eq :data }
  end

  describe '#conversions' do
    subject { file.conversions }

    context 'after initialization' do
      it { is_expected.to be_empty }
    end

    context 'after adding a conversion' do
      before { file.add_conversion(:foo, :bar) }
      it { is_expected.to eq foo: :bar }
    end
  end
end
