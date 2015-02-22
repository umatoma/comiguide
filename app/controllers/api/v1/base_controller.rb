class Api::V1::BaseController < ActionController::Base

  # ----------------------------------------------------------
  # CSRF
  # ----------------------------------------------------------
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  skip_before_action :initialize_variables
  skip_before_action :verify_authenticity_token

  before_action :validate_request_format
  before_action :authenticate_user_from_api_token

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def authenticate_user_from_api_token
    render json: { error: '401 Unauthorized' }, status: :unauthorized unless current_user
  end

  def current_ability
    @api_current_ability ||= ApiAbility.new(current_user)
  end

  def current_user
    @api_current_user ||= User.first
    # @api_current_user ||= ApiToken.includes(:user).find_by_token(request.headers['X-Comiguide-Api-Token']).try(:user)
  end

  def json_request?
    request.format.json?
  end

  def access_denied(exception)
    render json: { error: exception.message }, status: :unauthorized
  end

  def parameter_missing(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def validate_request_format
    render json: { error: '404 Not Found' }, status: :not_found unless json_request?
  end
end
