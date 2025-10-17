module Categories
  class CategoryService
    def initialize(params)
      @params = params
    end

    def create
      category = Category.new(@params)
      if category.save
        return {category: category, status: :created}
      else
        return {category: category, status: :unprocessable_entity}
      end
    end

    def update(category)
      if category.update(@params.except(:id))
        {category: category, status: :updated}
      else
        {category: category, errors: category.errors.full_messages, status: :unprocessable_entity}
      end
    end


    def destroy(deleted_category)
      category = Category.find(deleted_category[:id])
      if category.destroy
        return true
      else
        return false
      end
    end
    
  end
end
