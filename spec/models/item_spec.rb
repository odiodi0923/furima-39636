require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '出品できる場合' do
      it '必要事項を全て過不足なく入力すると出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'item_imageが空では登録できない' do
        @item.item_image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end

      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("説明を入力してください")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it 'priceが300以下だと登録できない' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は設定範囲外です')
      end

      it 'priceが9_999_999以上だと登録できない' do
        @item.price = '1000000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は設定範囲外です')
      end

      it 'priceが全角だと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を半角文字で入力してください')
      end

      it 'category_idが1では登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it 'condition_idが1では登録できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("状態を入力してください")
      end

      it 'fee_option_idが1では登録できない' do
        @item.fee_option_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料を入力してください")
      end

      it 'region_idが1では登録できない' do
        @item.region_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it 'delivery_d_idが1では登録できない' do
        @item.delivery_d_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
