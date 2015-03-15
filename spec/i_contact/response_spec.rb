require 'spec_helper'

describe IContact::Response do
  let(:mock_raw_resp) do
    mock_resp = mock.tap do |m|
      m.stubs(:body).returns('{"errors":["Resource Or Version Not Implemented"]}')
      m.stubs(:status).returns(200)
    end
  end

  let(:response) { IContact::Response.new(mock_raw_resp) }

  it 'finds errors when present' do
    expect(response.errors).to eql(JSON.parse(mock_raw_resp.body)["errors"])
  end

  it 'is invalid when errors are present' do
    response.stubs(:errors).returns(['something is wonky'])
    expect(response).not_to be_valid
  end

  it 'is valid when errors are present' do
    response.stubs(:errors).returns([])
    expect(response).to be_valid
  end
end

