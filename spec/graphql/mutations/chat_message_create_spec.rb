require 'rails_helper'

describe 'chatMessageCreate', type: :graphql do

  let(:user) { users(:default) }
  let(:channel_name) { 'general' }
  let(:body) { 'Hello World' }
  let(:image_url) { 'https://media0.giphy.com/media/Ju7l5y9osyymQ/200.webp?cid=ecf05e4725506vuum9ldrix2dt8fdrtszgijxpf49qwlw4al&rid=200.webp&ct=g' }
  
  let(:context) {
    {
      current_user: user
    }
  }
  let(:q) {
    <<-GQL
      mutation ChatMessageCreate($channelName: String!, $body: String, $imageUrl: String) {
        chatMessageCreate(input: { 
          channelName: $channelName, 
          body: $body, 
          imageUrl: $imageUrl 
        }) {
          message {
            body
            imageUrl
            author {
              id
              name
            }
            channel {
              name
            }
          }
          errors {
            attribute
            message
          }
        }
      }
    GQL
  }

  it 'success' do
    response = mutation(q, variables: { channel_name: channel_name, body: body, image_url: image_url }, context: context)
    expect(response.errors.present?).to eq(false)
    expect(response.data['chatMessageCreate']['errors'].blank?).to eq(true)
    expect(response.data['chatMessageCreate']['message']).to eq({
      'author' => { 
        'id' => user.id.to_s, 
        'name' => user.name
      }, 
      'body' => body, 
      'channel' => {
        'name' => channel_name
      },
      'imageUrl' => image_url
    })

    channel = Channel.find_by(name: channel_name)
    expect(channel.users_count).to eq(1)
    expect(channel.messages_count).to eq(1)
  end

  it 'blank content' do
    response = mutation(q, variables: { channel_name: channel_name }, context: context)
    expect(response.attribute_errors('chatMessageCreate', 'base')).to include('Either body or image_url is required')
  end

end
