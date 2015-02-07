module Kamikakushi
  module Kaonashi
    extend ActiveSupport::Concern

    module ClassMethods
      def kaonashi(options = {})
        define_singleton_method(:dependent_parent_name) { options[:parent] }
        return unless dependent_parent_name

        class_eval do
          include InstanceMethods
          default_scope { without_deleted }
          alias_method_chain :destroyed?, :kaonashi

          scope :with_deleted, -> {
            join_with_dependent_parent(dependent_parent_name, :with_deleted)
          }

          scope :without_deleted, -> {
            join_with_dependent_parent(dependent_parent_name, :without_deleted)
          }

          scope :only_deleted, -> {
            join_with_dependent_parent(dependent_parent_name, :only_deleted)
          }
        end
      end

      private

      def join_with_dependent_parent(dependent_parent_name, scope_name)
        association =  reflect_on_all_associations.find { |a| a.name == dependent_parent_name }
        dependent_parent_class =  association.klass

        parent_arel = dependent_parent_class.arel_table
        joins_conditions = arel_table.join(parent_arel)
                                    .on(parent_arel[:id].eq arel_table[association.foreign_key])
                                    .join_sources
        joins(joins_conditions).merge(dependent_parent_class.__send__(scope_name))
      end
    end

    module InstanceMethods
      def destroyed_with_kaonashi?
        association =  self.class.reflect_on_all_associations.find { |a| a.name == self.class.dependent_parent_name }
        association.klass.with_deleted.find(__send__(association.foreign_key)).destroyed?
      end
    end
  end
end
