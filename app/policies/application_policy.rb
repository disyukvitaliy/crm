class ApplicationPolicy
  attr_reader :user, :record, :section

  def initialize(user, object)
    init_vars(user, object)
  end

  def index?
    can? :index
  end

  def show?
    can? :show
  end

  def create?
    can? :create
  end

  def new?
    create?
  end

  def update?
    can? :update
  end

  def edit?
    update?
  end

  def destroy?
    can? :destroy
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
    @record, @section = [object, object.class.name] if object.is_a?(ActiveRecord::Base)
    @section = object if object.is_a?(Symbol) || object.is_a?(String)
    @section ||= object.name
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
end
