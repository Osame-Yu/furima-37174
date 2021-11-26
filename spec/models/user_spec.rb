require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる' do
      it 'nickname,email,password,password_confirmation,first_name,last_name,first_name_kana,last_name_kana,birthdayの値が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'first_nameが漢字・ひらがな・全角カタカナであれば登録できる' do
        @user.first_name = '鈴木'
        expect(@user).to be_valid
      end
      it 'last_nameが漢字・ひらがな・全角カタカナであれば登録できる' do
        @user.last_name = '史朗'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角カタカナであれば登録できる' do
        @user.first_name_kana = 'スズキ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角カタカナであれば登録できる' do
        @user.last_name_kana = 'シロウ'
      end
    end

    context '新規登録ができない' do
      it 'nicknameがなければ登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailがなければ登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'aaaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordがなければ登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a11111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both numbers and letters")
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both numbers and letters")
      end
      it 'passwordに全角文字を含むと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both numbers and letters")
      end
      it 'first_nameがなければ登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameがなければ登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_name_kanaがなければ登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaがなければ登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_nameが漢字・ひらがな・全角カタカナでなければ登録できない' do
        @user.first_name ='Tom'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name must be full-width characters")
      end
      it 'last_nameが漢字・ひらがな・全角カタカナでなければ登録できない' do
        @user.last_name ='Riddle'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name must be full-width characters")
      end
      it 'first_name_kanaが全角カタカナでなければ登録できない' do
        @user.first_name_kana ='Harry'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana must be full-width katakana characters")
      end
      it 'last_name_kanaが全角カタカナなければ登録できない' do
        @user.last_name_kana ='Potter'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana must be full-width katakana characters")
      end
      it 'birthdayがなければ登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end 
end
