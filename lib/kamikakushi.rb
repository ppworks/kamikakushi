module Kamikakushi
  extend ActiveSupport::Concern

  included do
    default_scope { without_deleted }
    alias_method_chain :destroy, :kamikakushi
    alias_method_chain :destroyed?, :kamikakushi

    scope :with_deleted, -> {
      unscope(where: :deleted_at)
    }

    scope :without_deleted, -> {
      where(deleted_at: nil)
    }

    scope :only_deleted, -> {
      with_deleted.where.not(deleted_at: nil)
    }
  end

  def destroy_with_kamikakushi
    update_column(:deleted_at, Time.current)
  end

  def destroyed_with_kamikakushi?
    self.deleted_at? || destroyed_without_kamikakushi?
  end

  def restore
    update_column(:deleted_at, self.deleted_at = nil)
  end

  def purge
    destroy_without_kamikakushi
  end
end
