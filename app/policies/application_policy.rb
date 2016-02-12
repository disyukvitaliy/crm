class ApplicationPolicy
  attr_reader :user, :record, :section

  def initialize(user, object)
    init_vars(user, object)
  end

  # note that index is not using scope.
  # this is done for clarity.
  # you can view list of all records but show and edit only records you have access to
  def index?
    can? :index
  end

  def show?
    can?(:show) && record_in_scope?
  end

  def create?
    can? :create
  end

  def new?
    create?
  end

  def update?
    can?(:update) && record_in_scope?
  end

  def edit?
    update?
  end

  def destroy?
    can?(:destroy) && record_in_scope?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  # TODO object.is_a?(ActiveRecord::Base) maybe something else?
  def init_vars(user, object)
    @user = user
    @record = nil
    @record, @section = [object, object.class.name] if object.is_a?(ActiveRecord::Base) # object is a record (Project.first)
    @section = object if object.is_a?(Symbol) || object.is_a?(String) # object is String or Symbol (:Admin, :Dashboard)
    @section ||= object.name # object is a model Class (Project)
  end

  # @param action [String,Symbol]
  # @return [Bool] true if can perform action, false if not
  def can?(action)
    find_permission(action) ? true : false
  end

  # @param action [String,Symbol]
  # @return [ActiveRecord::Base, nil]
  def find_permission(action)
    user.role.permissions.where('section = ? AND action = ?', section, action).first
  end

  # @return [Bool] - true if record is found in scope, false if not
  def record_in_scope?
    find_record_in_scope ? true : false
  end

  # Search record in available scope
  # @return [ActiveRecord::Base, nil] - nil if not found
  def find_record_in_scope
    scope.where(id: record.id).first
  end
end
