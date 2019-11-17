FactoryBot.define do
  factory :entry do
    title { 'entryタイトル' }
    association :blog
  end
end
