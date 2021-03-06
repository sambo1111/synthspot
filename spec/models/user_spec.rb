require 'rails_helper'

RSpec.describe User, type: :model do
  it "is saved if given correct credits" do
    user = User.create username:"user", password:"salainen", password_confirmation:"salainen"
    expect(user).to be_valid
    expect(User.count).to eq(1)
  end

  it "is not saved if given improper name" do
    user = User.create username:"us", password:"salainen", password_confirmation:"salainen"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved if given wrong password confirmation" do
    user = User.create username:"user", password:"salainen", password_confirmation:"salainen12"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved if exists another with the same username" do
    user = User.create username:"user", password:"salainen", password_confirmation:"salainen"
    user2 = User.create username:"user", password:"salis", password_confirmation:"salis"

    expect(user2).not_to be_valid
    expect(User.count).to eq(1)
  end

  it "is found if searched with a right word" do
    user1 = User.create username:"jimihendrix", password:"salainen", password_confirmation:"salainen"
    user2 = User.create username:"usainbolt", password:"salainen", password_confirmation:"salainen"

    result_users = User.search("usain")

    expect(result_users.size).to eq(1)
    expect(result_users.first.username).to eq(user2.username)
  end
end
