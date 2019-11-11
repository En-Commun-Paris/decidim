# frozen_string_literal: true

module Decidim
  module Admin
    # The main application controller that inherits from Rails.
    class ApplicationController < ::DecidimController
      include NeedsOrganization
      include NeedsPermission
      include FormFactory
      include LocaleSwitcher
      include PayloadInfo
      include HttpCachingDisabler

      helper Decidim::Admin::ApplicationHelper
      helper Decidim::Admin::AttributesDisplayHelper
      helper Decidim::Admin::SettingsHelper
      helper Decidim::Admin::IconLinkHelper
      helper Decidim::Admin::MenuHelper
      helper Decidim::Admin::ScopesHelper
      helper Decidim::DecidimFormHelper
      helper Decidim::ReplaceButtonsHelper
      helper Decidim::ScopesHelper
      helper Decidim::TranslationsHelper
      helper Decidim::LanguageChooserHelper
      helper Decidim::ComponentPathHelper
      helper Decidim::SanitizeHelper

      helper_method :per_page, :max_per_page

      default_form_builder Decidim::Admin::FormBuilder

      protect_from_forgery with: :exception, prepend: true

      register_permissions(::Decidim::Admin::ApplicationController,
                           ::Decidim::Admin::Permissions)

      def user_has_no_permission_path
        decidim_admin.root_path
      end

      def user_not_authorized_path
        decidim_admin.root_path
      end

      def permission_class_chain
        ::Decidim.permissions_registry.chain_for(::Decidim::Admin::ApplicationController)
      end

      def permission_scope
        :admin
      end

      def default_per_page
        Decidim::Admin.default_per_page
      end

      def max_per_page
        Decidim::Admin.max_per_page
      end

      def per_page
        params[:per_page].present? ? params[:per_page].first : default_per_page
      end
    end
  end
end
