require 'rails_helper'

RSpec.describe Labeling, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:label) { Label.create!(name: "Label") }

  it { is_expected.to belong_to :labelable }

  describe "labelings" do
    it "should allow the same label to be associated with a different topic and post" do
      topic.labels << label
      post.labels << label
      topic_label = topic.labels[0]
      post_label = post.labels[0]
      
      expect(topic_label).to eq(post_label)
    end
  end
end