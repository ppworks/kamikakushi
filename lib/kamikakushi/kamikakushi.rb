module Kamikakushi
  module Kamikakushi
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def kamikakushi(options = {})
        options.reverse_merge!(column_name: :deleted_at)
        define_singleton_method(:kamikakushi_column_name) { options[:column_name] }
        class_eval do
          include InstanceMethods
          default_scope { without_deleted }
          alias_method_chain :destroy, :kamikakushi
          alias_method_chain :destroyed?, :kamikakushi

          scope :with_deleted, -> {
            unscope(where: kamikakushi_column_name.to_sym)
          }

          scope :without_deleted, -> {
            where(kamikakushi_column_name => nil)
          }

          scope :only_deleted, -> {
            with_deleted.where.not(kamikakushi_column_name => nil)
          }
        end
      end
    end

    module InstanceMethods
      def destroy_with_kamikakushi
        run_callbacks(:destroy) do
          touch(self.class.kamikakushi_column_name)
        end
      end

      def destroyed_with_kamikakushi?
        self.deleted_at? || destroyed_without_kamikakushi?
      end

      def restore
        update_column(self.class.kamikakushi_column_name.to_sym, write_attribute(self.class.kamikakushi_column_name, nil))
      end

      def purge
        destroy_without_kamikakushi
      end
    end
  end
end
