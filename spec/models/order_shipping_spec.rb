require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
  end


  describe '商品購入機能' do
    # 商品購入機能についてのテストコードを記述します
    context '購入ができる時' do
      it '正しい情報で購入できること' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingが空でも購入できること' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '購入ができない時' do
      it 'user_idがない状態では購入できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがない状態では購入できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeが空では登録できない' do
        @order_shipping.postal_code = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeにハイフンが入っていないと登録できない' do
        @order_shipping.postal_code = '1111111'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが選択されていない状態では登録できない' do
        @order_shipping.prefecture_id = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @order_shipping.city = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空では登録できない' do
        @order_shipping.addresses = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @order_shipping.phone_number = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが9桁以下では登録できない' do
        @order_shipping.phone_number = '123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが12桁以上は登録できない' do
        @order_shipping.phone_number = '123456789012'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberは数字のみしか登録できない' do
        @order_shipping.phone_number = '000-0000-0000'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'tokenが空では登録できない' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
