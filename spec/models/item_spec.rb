require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    it 'nameとdescription、category_id、condition_id、delv_fee_id、delv_from_id、delv_time_id、price、imageが存在すれば登録出来ること' do
      expect(@item).to be_valid
    end

    it '商品名が空だと登録できないこと' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end

    it '商品の説明が空だと登録できないこと' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Description can't be blank"
    end

    it 'カテゴリーの情報がないと登録できないこと' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Category must be other than 1'
    end

    it '商品の状態についての情報がないと登録できないこと' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Condition must be other than 1'
    end

    it '配送料の負担についての情報がないと登録できないこと' do
      @item.delv_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Delv fee must be other than 1'
    end

    it '発送元の地域についての情報がないと登録できないこと' do
      @item.delv_from_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Delv from must be other than 1'
    end

    it '発送までの日数についての情報がないと登録できないこと' do
      @item.delv_time_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include 'Delv time must be other than 1'
    end

    it '価格が空だと登録できないこと' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end

    it '価格の範囲が、¥300より小さいと登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be greater than or equal to 300'
    end

    it '価格の範囲が、¥9,999,999より大きいと登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
    end

    it '価格は半角数字以外だと登録できないこと' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price is not a number'
    end
  end
end
