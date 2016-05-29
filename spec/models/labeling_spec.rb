require 'rails_helper'

RSpec.describe Labeling, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:label) { create(:label, name: "Label") }

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