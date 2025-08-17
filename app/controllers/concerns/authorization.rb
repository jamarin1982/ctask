module Authorization
  extend ActiveSupport::Concern

  included do
    class NotAuthorizedError < StandardError;  end

    rescue_from NotAuthorizedError do
      redirect_to home_path, alert: t("common.not_authorized")
    end
  end

  private

  def authorize!(record = nil)
    policy_class = "#{controller_name.singularize}Policy".classify.constantize
    is_allowed = policy_class.new(record).send(action_name)
    raise NotAuthorizedError unless is_allowed
  end
end
