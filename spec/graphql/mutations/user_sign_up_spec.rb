require 'rails_helper'

describe 'userSignIn', type: :graphql do

  let(:name) { 'John Smith' }
  
  let(:context) {
    {}
  }
  let(:q) {
    <<-GQL
      mutation UserSignUp($name: String!) {
        userSignUp(input: { name: $name }) {
          user {
            id
            name
            authToken
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
    response = mutation(q, variables: { name: name }, context: context)
    expect(response.errors.present?).to eq(false)
    expect(response.data['userSignUp']['user']['id'].present?).to eq(true)
  end

  it 'invalid name' do
    response = mutation(q, variables: { name: '' }, context: context)
    expect(response.attribute_errors('userSignUp', 'name')).to include("can't be blank")
    expect(response.data['userSignUp']['user'].blank?).to eq(true)
  end

end
