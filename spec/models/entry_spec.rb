require 'rails_helper'

RSpec.describe Entry, type: :model do
  it 'titleがあれば有効な状態であること' do
    entry = FactoryBot.create(:entry)
    expect(entry).to be_valid
  end

  it 'titleがなければ無効な状態であること' do
    entry = FactoryBot.build(:entry, title: nil)
    entry.valid?
    expect(entry.errors[:title]).to include("can't be blank")
  end
end
