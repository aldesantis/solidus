# frozen_string_literal: true

module Solidus
  module Api
    class PropertiesController < Solidus::Api::BaseController
      before_action :find_property, only: [:show, :update, :destroy]

      def index
        @properties = Solidus::Property.accessible_by(current_ability, :read)

        if params[:ids]
          ids = params[:ids].split(",").flatten
          @properties = @properties.where(id: ids)
        else
          @properties = @properties.ransack(params[:q]).result
        end

        @properties = paginate(@properties)
        respond_with(@properties)
      end

      def show
        respond_with(@property)
      end

      def new
      end

      def create
        authorize! :create, Property
        @property = Solidus::Property.new(property_params)
        if @property.save
          respond_with(@property, status: 201, default_template: :show)
        else
          invalid_resource!(@property)
        end
      end

      def update
        if @property
          authorize! :update, @property
          @property.update(property_params)
          respond_with(@property, status: 200, default_template: :show)
        else
          invalid_resource!(@property)
        end
      end

      def destroy
        if @property
          authorize! :destroy, @property
          @property.destroy
          respond_with(@property, status: 204)
        else
          invalid_resource!(@property)
        end
      end

      private

      def find_property
        @property = Solidus::Property.accessible_by(current_ability, :read).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @property = Solidus::Property.accessible_by(current_ability, :read).find_by!(name: params[:id])
      end

      def property_params
        params.require(:property).permit(permitted_property_attributes)
      end
    end
  end
end
