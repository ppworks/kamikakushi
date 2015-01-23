require 'spec_helper'

RSpec.describe KamiKakushi do
  let!(:post) { Post.create(title: 'demo') }

  describe 'select record' do
    subject { Post.all.to_sql }
    it { is_expected.to include 'WHERE "posts"."deleted_at" IS NULL' }
  end

  describe 'logical delete' do
    it do
      expect {
        post.destroy
      }.to change(post, :deleted_at).from(nil)
    end
  end
end
