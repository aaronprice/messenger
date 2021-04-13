require 'rails_helper'

describe 'images', type: :graphql do
  let(:search_string) { 'funny' }

  let(:context) {
    {}
  }
  let(:q) {
    <<-GQL
      query Images($search: String!) {
        images(search: $search) {
          id
          url
        }
      }
    GQL
  }

  let(:images) { 
    [
      double('Giphy::Gif', id: '26tP3M3i03hoIYL6M', url: 'https://giphy.com/gifs/afv-funny-fail-lol-26tP3M3i03hoIYL6M'),
      double('Giphy::Gif', id: '2A75RyXVzzSI2bx4Gj', url: 'https://giphy.com/gifs/hallmarkecards-cute-hallmark-shoebox-2A75RyXVzzSI2bx4Gj'),
      double('Giphy::Gif', id: 'SggILpMXO7Xt6', url: 'https://giphy.com/gifs/sblobbery-clbarrr-idzz-SggILpMXO7Xt6'),
      double('Giphy::Gif', id: '1hqYk0leUMddBBkAM7', url: 'https://giphy.com/gifs/justin-mood-monday-mondays-1hqYk0leUMddBBkAM7'),
      double('Giphy::Gif', id: 'wW95fEq09hOI8', url: 'https://giphy.com/gifs/chihuahua-funny-cute-wW95fEq09hOI8')
    ]
  }

  it 'success' do
    expect(Giphy).to receive(:search).with(search_string, anything).and_return(images)
    response = query(q, variables: { search: search_string }, context: context)
    
    expect(response.errors.present?).to eq(false)
    expect(response.data['images']).to eq([{ 
      'id' => '26tP3M3i03hoIYL6M', 
      'url' => 'https://giphy.com/gifs/afv-funny-fail-lol-26tP3M3i03hoIYL6M'
    }, {
      'id' => '2A75RyXVzzSI2bx4Gj', 
      'url' => 'https://giphy.com/gifs/hallmarkecards-cute-hallmark-shoebox-2A75RyXVzzSI2bx4Gj'
    }, {
      'id' => 'SggILpMXO7Xt6', 
      'url' => 'https://giphy.com/gifs/sblobbery-clbarrr-idzz-SggILpMXO7Xt6'
    }, {
      'id' => '1hqYk0leUMddBBkAM7', 
      'url' => 'https://giphy.com/gifs/justin-mood-monday-mondays-1hqYk0leUMddBBkAM7'
    }, {
      'id' => 'wW95fEq09hOI8', 
      'url' => 'https://giphy.com/gifs/chihuahua-funny-cute-wW95fEq09hOI8'
    }])
  end
end
