require 'rails_helper'

describe 'users', type: :graphql do

  let!(:user) { users(:default) }
  
  let(:context) {
    {}
  }
  let(:q) {
    <<-GQL
      query Users {
        users {
          edges {
            node {
              id
              name
            }
          }
        }
      }
    GQL
  }

  it 'success' do
    response = query(q, context: context)
    
    expect(response.errors.present?).to eq(false)
    expect(response.data['users']).to eq({
      'edges' => [{ 
        'node' => {
          'id' => user.id.to_s, 
          'name' => user.name 
        }
      }]
    })
  end
end
