# you can update has_many relations via POST from form
# one can pass array of ids to relation
# @example
#   User.first.accessed_projects = [1,2,3] or ['1','2','3']
#
module HasManyUpdaterConcern
  extend ActiveSupport::Concern

  class_methods do

    # @param relation_name [String, Symbol] - name of has_many relation
    # @param related_model_class [ActiveRecord::Base] - related model class
    # @example
    #
    #   class User < ActiveRecord::Base
    #     include HasManyUpdaterConcern
    #     has_many_updater :accessed_projects, Project
    #     has_many :accessed_projects, through: :user_projects, source: 'project'
    #   end
    #
    def has_many_updater(relation_name, related_model_class)

      define_method("#{relation_name}=") do |relations|
        relations = relations.reject {|item| item == ''}
        if relations.blank?
          self.send(relation_name).delete_all
        else
          # whether array consist of integers or records
          # if first, find all records and pass its to super
          # if second, pass to super as is
          relation.first.to_i rescue false ? super(relations) : super(related_model_class.find(relations))
        end
      end
    end
  end
end