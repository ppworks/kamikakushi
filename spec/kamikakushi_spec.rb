require 'spec_helper'

RSpec.describe Kamikakushi::Kamikakushi do
  let!(:post) { Post.create(title: 'demo') }
  after { Post.with_deleted.delete_all }

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

    it 'should call before_destroy callback ' do
      expect {
        post.protected = true
        post.destroy
      }.not_to change(post, :deleted_at).from(nil)
    end

    it 'should call after_destroy callback' do
      expect {
        post.destroy
      }.to change(post, :comment_after_destroy).from(nil).to('KAMIKAKUSHI')
    end
  end

  describe 'real delete' do
    it do
      expect {
        post.purge
        post.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#destroyed?' do
    it do
      expect {
        post.destroy
      }.to change(post, :destroyed?).from(false).to(true)
    end
  end

  describe '#restore' do
    before { post.destroy }

    it do
      expect {
        post.restore
        post.reload
      }.to change(post, :destroyed?).from(true).to(false)
    end
  end

  describe 'scope' do
    let!(:deleted_post) { Post.create(title: 'deleted', deleted_at: Time.current) }

    describe '.with_deleted' do
      subject { Post.with_deleted.all.to_a }
      it { is_expected.to include post }
      it { is_expected.to include deleted_post }
    end

    describe '.without_deleted' do
      subject { Post.without_deleted.all.to_a }
      it { is_expected.to include post }
      it { is_expected.not_to include deleted_post }
    end

    describe '.only_deleted' do
      subject { Post.only_deleted.all.to_a }
      it { is_expected.not_to include post }
      it { is_expected.to include deleted_post }
    end
  end
end
