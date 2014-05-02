require 'spec_helper'

describe SearchResultSet do

  let(:attributes) do
    {
      'q' => 'bla',
      'remote_images' => [],
      'local_images' => [],
      'templates' => []
    }
  end

  it_behaves_like 'a view model'

  describe '.build_from_response' do
    subject { SearchResultSet }

    let(:fake_json_response) { attributes.to_json }

    it 'instatiates itself with the parsed json attributes' do
      result = subject.build_from_response(fake_json_response)

      expect(result).to be_a SearchResultSet
      expect(result.query).to eql 'bla'
      expect(result.remote_images).to eql []
      expect(result.local_images).to eql []
    end

    it 'does not blow up if remote images is not defined' do
      without_remote_images = attributes.except(:remote_images).to_json
      expect {
        subject.build_from_response(without_remote_images)
      }.to_not raise_error
    end
  end

  describe '#as_json' do
    subject { SearchResultSet.new(attributes) }

    it 'provides the attributes to be converted to JSON' do
      expected = {
        'query' => 'bla',
        'remote_images' => [],
        'local_images' => [],
        'templates' => []
      }
      expect(subject.as_json).to eq expected
    end
  end
end
