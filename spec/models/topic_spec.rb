require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }
  
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_length_of(:description).is_at_least(15) }
  
  describe "attributes" do
    it "should have name, description, and public attributes" do
      expect(topic). to have_attributes(name: topic.name, description: topic.description)
    end
    
    it "should be public by default" do
      expect(topic.public).to be(true)
    end
  end

  describe "scopes" do
    before do
      @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = User.new
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end

      it "returns only public topics if user is nil" do
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end

    describe "pubicly_viewable" do
      it "returns a collection of publicly viewable topis" do
        expect(Topic.publicly_viewable).to eq(Topic.where(public: true))
      end
    end

    describe "privately_viewable" do
      it "returns a collection of privately viewable topis" do
        expect(Topic.privately_viewable).to eq(Topic.where(public: false))
      end
    end
  end
end
