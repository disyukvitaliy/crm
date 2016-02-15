# @see http://stackoverflow.com/questions/244243/how-to-reset-postgres-primary-key-sequence-when-it-falls-out-of-sync
class Seeds::SetvalIdSequencesService
  def call
    tables.each do |table|
      ActiveRecord::Base.connection.execute("SELECT setval('#{table}_id_seq', (SELECT max(id) FROM #{table}));")
    end
  end

  def tables
    [:projects, :issues, :time_entries, :activities, :issue_priorities, :issue_statuses,
    :permissions, :profiles, :roles, :settings, :users]
  end
end
