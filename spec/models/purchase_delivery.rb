require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it 'token,post_num,prefecture_id,city,address,building,phoneがあれば購入できる' do
        expect(@purchase_delivery).to be_valid
      end
      it 'buildingがなくても購入できる' do
        @purchase_delivery.building = ''
        expect(@purchase_delivery).to be_valid
      end
      it 'phoneが10桁の整数であれば購入できる' do
        @purchase_delivery.phone = 1_234_567_890
        expect(@purchase_delivery).to be_valid
      end
    end
    context '購入できない場合' do
      it 'tokenがなければ購入できない' do
        @purchase_delivery.token = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_numがなければ購入できない' do
        @purchase_delivery.post_num = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Post num can't be blank")
      end
      it 'post_numが(3桁の半角数字 + ハイフン(-) + 4桁の半角数字)でなければ登録できない' do
        @purchase_delivery.post_num = '12345678'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Post num must include both numbers and hyphen(-)')
      end
      it 'prefecture_idが1の場合は購入できない' do
        @purchase_delivery.prefecture_id = 1
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityがなければ購入できない' do
        @purchase_delivery.city = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("City can't be blank")
      end
      it 'addressがなければ購入できない' do
        @purchase_delivery.address = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneがなければ購入できない' do
        @purchase_delivery.phone = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが半角数字でなければ購入できない' do
        @purchase_delivery.phone = 'アイウエオ'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone must be numbers')
      end
      it 'phoneが9文字以下では購入できない' do
        @purchase_delivery.phone = 123_456_789
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone is too short (minimum is 10 characters)')
      end
    end
  end
end
