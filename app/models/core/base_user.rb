module Core
  class BaseUser < ActiveRecord::Base
    self.table_name = "users"
    self.abstract_class = true

    class << self
      def inherited(child_class)
        super

        company_class = begin
          namespaced_class = "::#{child_class.name.deconstantize}::Company"
          namespaced_class.constantize.name
        rescue NameError
          warn "#{namespaced_class} is not defined. Using ::Core::Company instead"
          "::Core::Company"
        end

        child_class.belongs_to :company,
          class_name: company_class
      end
    end
  end
end
