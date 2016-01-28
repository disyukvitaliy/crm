class LeftMenu
  
  include Singleton
  attr_accessor :items, :project_id

  # TODO to config. I can't do this before i figure out how to solve cache-like problem.
  def initialize
    @items = {
      projects: {
        type: :tab,
        title: :Projects,
        items: {
          show_all: {title: 'Show all', type: :item, path: :projects_path, args: {}, show: true},
          new: {title: 'Create new', type: :item, path: :new_project_path, args: {}, show: true},
        },
      },
      issues: {
        type: :tab,
        title: :Issues,
        items: {
          show_all: {title: 'Show all', type: :item, path: :issues_path, args: {}, show: true},
          this_project: {title: 'This project only', type: :item, path: :project_issues_path, args: {project_id: nil}, show: true},
          new: {title: 'Create new', type: :item, path: :new_project_issue_path, args: {project_id: nil}, show: true},
        },
      },
    }
  end

  def prepare_items
    traverse @items
		self
  end

  def traverse items
    items.each do |key, element|
      if element[:type] == :tab
        traverse element[:items]
      elsif element[:type] == :item
				fill_args_for element
				define_visibility_for element
      end
    end
  end

  def fill_args_for item
		item[:args] = {project_id: @project_id} if item[:args].has_key?(:project_id)
  end

  def define_visibility_for item
		item[:show] = false if item[:args].has_value?(nil)
  end

end
