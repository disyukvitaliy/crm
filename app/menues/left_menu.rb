class LeftMenu
  include Singleton

  attr_accessor :items

  def initialize
    @items = {
      Projects: {
        show_all: {title: 'Show all', path: :projects_path, args: [], show: true},
        new: {title: 'Create new', path: :new_project_path, args: [], show: true},
      },
      Issues: {
        show_all: {title: 'Show all', path: :issues_path, args: [], show: true},
        this_project: {title: 'This project only', path: :project_issues_path, args: [], show: false},
        new: {title: 'Create new', path: :new_project_issue_path, args: [], show: false},
      },
    }
  end

  def project_id project_id
    [
      [:Issues, :this_project],
      [:Issues, :new],
    ].each do |block|
      @items[block[0]][block[1]][:show] = true
      @items[block[0]][block[1]][:args] = project_id
    end
  end
end
