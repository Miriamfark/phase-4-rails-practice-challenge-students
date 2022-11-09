class InstructorsController < ApplicationController

    def index 
        render json: Instructor.all
    end

    def show 
        instructor = Instructor.find(params[:id])
        render json: instructor
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Instructor not found" }, status: :not_found
    end 

    def create 
        instructor = Instructor.create!(name: params[:name])
        render json: instructor
    rescue ActiveRecord::RecordInvalid => e
        render json: e.record.errors, status: :unprocessable_entity
    end

    def update 
        instructor = Instructor.find(params[:id])
        instructor.update(name: params[:name])
        render json: instructor
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Instructor not found" }, status: :not_found
    end 

    def destroy 
        instructor = Instructor.find(params[:id])
        instructor.destroy 
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Instructor not found" }, status: :not_found
    end

end
