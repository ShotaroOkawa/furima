require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nicknameとemail、password、password_confirmation、family_name、first_name、firmily_name_kana、first_name_kana、birthdayが存在すれば登録出来ること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空だと登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'emailが空だと登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it '既に登録されたメールアドレスが存在する場合、登録出来ないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空だと登録出来ないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'passwordが5文字以下だと登録できないこと' do
      @user.password = 'abc12'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end

    it 'passwordが半角英語だけだと登録できないこと' do
      @user.password = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password includes both letters and numbers'
    end

    it 'passwordが半角数字だけだと登録できないこと' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password includes both letters and numbers'
    end

    it 'password_confirmationが空だと登録出来ないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'family_nameが空だと登録できないこと' do
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Family name can't be blank"
    end

    it 'first_nameが空だと登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'family_nameが半角だと登録できないこと' do
      @user.family_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name Full-width characters'
    end

    it 'first_nameが半角だと登録できないこと' do
      @user.family_name = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name Full-width characters'
    end

    it 'family_name_kanaが空だと登録できないこと' do
      @user.family_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Family name kana can't be blank"
    end

    it 'first_name_kanaが空だと登録できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end

    it 'family_name_kanaが全角カタカナ以外だと登録できないこと' do
      @user.family_name_kana = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name kana Full-width katakana characters'
    end

    it 'first_name_kanaが全角カタカナ以外だと登録できないこと' do
      @user.family_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name kana Full-width katakana characters'
    end

    it 'birthdayが空だと登録できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end

    it 'Emailに@がないと保存できない' do
      @user.email = 'testemail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end
  end
end
