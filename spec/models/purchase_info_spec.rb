require 'rails_helper'

RSpec.describe PurchaseInfo, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_info = FactoryBot.build(:purchase_info, user_id: user.id, item_id: item.id)
  end

  describe 'purchase_infoの保存' do
    context '保存できる場合' do
      it '必要事項を全て過不足なく入力すると保存できる' do
        expect(@purchase_info).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_info.building = ''
        expect(@purchase_info).to be_valid
      end
    end


    context '保存できない場合' do
      it 'postal_codeが空では登録できない' do
        @purchase_info.postal_code = ''
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'postal_codeにハイフンがないと登録できない' do
        @purchase_info.postal_code = '1234567'
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'postal_codeは全角では登録できない' do
        @purchase_info.postal_code = '123-３３３３'
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'region_idが1では登録できない' do
        @purchase_info.region_id = '1'
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Region can't be blank")
      end

      it 'cityが空では登録できない' do
        @purchase_info.city = ''
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("City can't be blank")
      end

      it 'street_numが空では登録できない' do
        @purchase_info.street_num = ''
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Street num can't be blank")
      end

      it 'phoneが空では登録できない' do
        @purchase_info.phone = ''
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Phone can't be blank")
      end

      it 'phoneが9桁以下では登録できない' do
        @purchase_info.phone = '22222222'
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが12桁以上では登録できない' do
        @purchase_info.phone = '2222222222222'
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが全角では登録できない' do
        @purchase_info.phone = '２２２２２２２２２２'
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Phone is invalid")
      end

      it 'itemが紐付いていなければ投稿できない' do
        @purchase_info.item_id = nil
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Item can't be blank")
      end

      it 'userが紐付いていなければ投稿できない' do
        @purchase_info.user_id = nil
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("User can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @purchase_info.token = nil
        @purchase_info.valid?
        expect(@purchase_info.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end