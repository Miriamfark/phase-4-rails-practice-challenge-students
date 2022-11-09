class StudentsController < ApplicationController

    def index 
        render json: Student.all
    end

    def show 
        student = find_student
        render json: student
    rescue ActiveRecord::RecordNotFound
        not_found_message
    end 

    def create 
        student = Student.create!(name: params[:name], major: params[:major], age: params[:age], instructor_id: params[:instructor_id])
        render json: student
    rescue ActiveRecord::RecordInvalid => e 
        render json: e.record.errors, status: :unprocessable_entity
    end

    def update 
        student = find_student
        student.update(student_params)
        render json: student
    rescue ActiveRecord::RecordNotFound
        not_found_message
    end 

    def destroy 
        student = find_student
        student.destroy 
        head :no_content
    rescue ActiveRecord::RecordNotFound
        not_found_message
    end

    private

    def student_params 
        params.permit(:name, :age, :major)
    end

    def find_student
        Student.find(params[:id])
    end

    def not_found_message
        render json: { error: "Student not found" }, status: :not_found
    end

end
