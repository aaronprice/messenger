require 'rails_helper'

describe Chats::Forms::CreateMessage do

  describe 'image_url' do

    describe 'valid' do
      it 'gif' do
        form = Chats::Forms::CreateMessage.new({ image_url: 'http://www.example.com/win.gif' }, {})
        form.valid?
        expect(form.errors[:image_url]).to eq([])
      end

      it 'webp' do
        form = Chats::Forms::CreateMessage.new({ image_url: 'http://www.example.com/win.webp' }, {})
        form.valid?
        expect(form.errors[:image_url]).to eq([])
      end

      it 'url with params' do
        form = Chats::Forms::CreateMessage.new({ image_url: 'http://www.example.com/win.webp?some=thing' }, {})
        form.valid?
        expect(form.errors[:image_url]).to eq([])
      end
    end

    

    it 'invalid' do
      form = Chats::Forms::CreateMessage.new({ image_url: 'http://' }, {})
      form.valid?
      expect(form.errors[:image_url]).to eq(['is invalid'])
    end
  end
  
end
