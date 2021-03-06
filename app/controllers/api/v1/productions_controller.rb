class Api::V1::ProductionsController < ApplicationController
    before_action :find_production, only: [:update, :destroy]
    before_action :requires_login, only: [:index, :show, :update, :destroy]
    
    def index
        @productions = Production.all
        render json: @productions
    end

    def create
        production = Production.new(production_params)
        if production.save
            render json: {'productionId' => production.id}
        else
            render json: {errors: production.errors.fullmessages}
        end
    end

    def update
        @production.update(user_params)
        if @production.save
            render json: @production, status: :accepted
        else
            render json: {errors: @production.errors.fullmessages}
        end
    end

    def destroy
        @production.destroy
        render json: {status: 'Deleted!'}
    end

    private
        def production_params
            params.permit(:user_id, :actor_id, :script_id, :img_url)
        end

        def find_production
            @production = Production.find(params[:id])
        end
end
