module Kamiakushi
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    alias_method_chain :destroy, :kamikakushi
    alias_method_chain :destroyed?, :kamikakushi
  end

  def destroy_with_kamikakushi
    self.deleted_at = Time.current
  end

  def destroyed_with_kamikakushi?
    self.deleted_at? || destroyed_without_kamikakushi?
  end
end
