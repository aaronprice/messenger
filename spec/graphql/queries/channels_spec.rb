require 'rails_helper'

describe 'channels', type: :graphql do

  let!(:user) { users(:default) }
  let!(:channel) { channels(:default) }
  let!(:message) { messages(:default) }
  
  let(:context) {
    {}
  }
  let(:q) {
    <<-GQL
      query Channels {
        channels {
          edges {
            node {
              id
              name
              messages {
                edges {
                  node {
                    id
                    body
                    imageUrl
                    author {
                      id
                      name
                    }
                  }
                }
              }
            }
          }
        }
      }
    GQL
  }

  it 'success' do
    response = query(q, context: context)
    
    expect(response.errors.present?).to eq(false)
    expect(response.data['channels']).to eq({
      'edges' => [{ 
        'node' => {
          'id' => channel.id.to_s, 
          'name' => channel.name, 
          'messages' => {
            'edges' => [{
              'node' => {
                'id' => message.id.to_s, 
                'body' => message.body, 
                'imageUrl' => message.image_url, 
                'author' => {
                  'id' => user.id.to_s, 
                  'name' => user.name
                }
              }
            }]
          }
        }
      }]
    })
  end
end
