# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video_view do
    video {Video.last.nil? ? FactoryGirl.create(:video) : video.last}
    user { User.where(type: nil).last.nil? ? FactoryGirl.create(:user) : User.where(type: nil).last}
  end
end
