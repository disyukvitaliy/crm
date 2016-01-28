class AddReferencesAndForeignKeysToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :issue_status, index: true
    add_reference :issues, :issue_priority, index: true
    add_foreign_key :issues, :projects, on_delete: :restrict, name: :fk_issues_on_project_id
    add_foreign_key :issues, :issue_statuses, on_delete: :nullify, name: :fk_issues_on_issue_status_id
    add_foreign_key :issues, :issue_priorities, on_delete: :nullify, name: :fk_issues_on_issue_priority_id
  end
end
