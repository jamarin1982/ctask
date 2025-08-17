class CategoryPolicy < BasePolicy
  def method_missing(method_name, *args, &block)
    Current.user&.admin?
  end
end
