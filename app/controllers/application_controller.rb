class ApplicationController < ActionController::Base
  # ----------------------------------------------------------
  # CSRF
  # ----------------------------------------------------------
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ----------------------------------------------------------
  # CanCanCan
  # ----------------------------------------------------------
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to main_app.root_path, alert: 'アクセス権限がありません。'
    else
      redirect_to main_app.new_user_session_path, notice: 'ログインして下さい。'
    end
  end

  # ----------------------------------------------------------
  # BeforeAction
  # ----------------------------------------------------------
  before_action :initialize_variables
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ----------------------------------------------------------
  # HelperMethod
  # ----------------------------------------------------------
  helper_method :add_stylesheet
  helper_method :add_script
  helper_method :integer_string?

  protected

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || mypage_users_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def request_json?
    request.format.symbol == :json
  end

  private

  def initialize_variables
    @page_keywords = %w(ComiGuide コミケ コミックマーケット Comiket ComicMarket COMIC1 企業ブース)
    @page_description = nil
    @page_stylesheets = []
    @page_scripts = []
  end

  def add_stylesheet(stylesheet)
    @page_stylesheets << stylesheet
  end

  def add_script(script)
    @page_scripts << script
  end

  def add_keyword(keyword)
    @page_keywords << keyword
  end

  def integer_string?(str)
    Integer(str)
    true
  rescue
    false
  end
end
