require 'spec_helper'

RSpec.describe Kamiakushi do
  let!(:post) { Post.create(title: 'demo') }

  describe 'select record' do
    subject { Post.all.to_sql }
    it { is_expected.to include 'WHERE "posts"."deleted_at" IS NULL' }
  end

  describe 'logical delete' do
    it do
      expect {
        post.destroy
        post.reload
      }.to change(post, :deleted_at).from(nil)
    end
  end

  describe '#destroyed?' do
    it do
      expect {
        post.destroy
      }.to change(post, :destroyed?).from(false).to(true)
    end
  end
end
