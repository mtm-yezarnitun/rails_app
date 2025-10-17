require_relative '../../forms/categories/category_form.rb'
module Categories
    class CategoryUsecase < BaseUseCase
        def initialize(params)
            @params = params
            @form = Categories::CategoryForm.new(params)
        end

        def create
            begin
                category_create_service = Categories::CategoryService.new(@form.attributes)
                if @form.valid?
                    response = category_create_service.create
                    if response[:status] == :created
                        return {category: response[:category], status: :created}
                    end
                    else
                        @category = Category.new(@form.attributes)
                    return {category: @category, errors: @form.errors, status: :unprocessable_entity}
                end
            rescue StandardError => errors
                return {category: @category, errors: errors.message, status: :unprocessable_entity}
            end
        end

        def update(category)
            return {category: category, errors: "Invalid form", status: :unprocessable_entity} unless @form.valid?

            service = Categories::CategoryService.new(@form.attributes)
            response = service.update(category) 

            response
        rescue StandardError => e
            {category: category, errors: e.message, status: :unprocessable_entity}
        end

        def destroy(deleted_category)
            begin
                category_delete_service = Categories::CategoryService.new(@params)
                if category_delete_service.destroy(deleted_category)
                    return true
                else
                    return false
                end
            rescue StandardError => errors
                return false
            end
        end
    end
end