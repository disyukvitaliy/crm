class LeftMenu
  include Singleton

  attr_accessor :items, :project_id

  def initialize
    @project_id = nil
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

  def get_items

    fill_args @items

  end

  def fill_args(items)

    items.each do |fst_lvl_key, item|

      puts item[:type] == :item

      if item[:type] == :tab

        fill_args item[:items]

      elsif item[:type] == :item

        item[:args] = {project_id: @project_id}

      end

    end

  end
end

# items.each do |fst_lvl_key, fst_lvl_item|
#
#   if fst_lvl_item[:type] == :tab
#
#     fst_lvl_item[:items].each do |snd_lvl_key, snd_lvl_item|
#       puts @items[fst_lvl_key][:items][snd_lvl_key][:args] = {project_id: @project_id}
#     end
#   end
#
# end
