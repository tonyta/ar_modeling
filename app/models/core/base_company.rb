module Core
  class BaseCompany < ActiveRecord::Base
    self.table_name = "companies"
    self.abstract_class = true

    class << self
      def inherited(child_class)
        super

        user_class = begin
          "::#{child_class.name.deconstantize}::User".constantize.name
        rescue NameError
          "::Core::User"
        end

        child_class.has_many :users,
          foreign_key: :company_id,
          class_name: user_class
      end
    end
  end
end
