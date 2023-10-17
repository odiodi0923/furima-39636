require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '必要事項を全て過不足なく入力すると登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        @another_user = FactoryBot.build(:user)
        @another_user.email = @user.email
        @another_user.valid?
        expect(@another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordが数字だと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  is invalid. Include both letters and numbers')
      end

      it 'passwordが英字だと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  is invalid. Include both letters and numbers')
      end

      it 'passwordが全角だと登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  is invalid. Include both letters and numbers')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが半角では登録できない' do
        @user.last_name = kato
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name  is invalid. Input full-width characters')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = taro
        @user.valid?
        expect(@user.errors.full_messages).to include('First name  is invalid. Input full-width characters')
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaが漢字では登録できない' do
        @user.last_name_kana = Gimei.name.last.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana  is invalid. Input full-width katakana characters')
      end

      it 'last_name_kanaがひらがなでは登録できない' do
        @user.last_name_kana = Gimei.name.last.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana  is invalid. Input full-width katakana characters')
      end

      it 'last_name_kanaが半角では登録できない' do
        @user.last_name_kana = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana  is invalid. Input full-width katakana characters')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = Gimei.name.first.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana  is invalid. Input full-width katakana characters')
      end

      it 'first_name_kanaがひらがなでは登録できない' do
        @user.last_name_kana = Gimei.name.first.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana  is invalid. Input full-width katakana characters')
      end

      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana  is invalid. Input full-width katakana characters')
      end

      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
