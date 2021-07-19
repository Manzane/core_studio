class CreditsUpdater
    attr_accessor :credits
    
    def initialize(params, user, options={})
      @params = params
      @user = user
      if options.has_key?(:lesson)
        @lesson = options[:lesson]
      end
    end

    def check_credits
        category = Category.find(@lesson.category_id)
        credit = @user.credits.find_by(category_id: category.id)
        if credit.quantity >= @params[:quantity].to_i
            return true
        else
            return false
        end
    end

    def increase
        category = Category.find(@lesson.category_id)
        credit = @user.credits.find_by(category_id: category.id)
        # raise
        credit.quantity += @params[:quantity].to_i
        if credit.save!
            return true
        else
            return false
        end
    end
    
    def decrease
        if @params["category"].nil?
            category = Category.find(@lesson.category_id)
        else
            category = Category.find(@params["category"].to_i)
        end
        credit = @user.credits.find_by(category_id: category.id)
        credit.quantity -= @params["quantity"].to_i
        # raise
        if credit.save!
            return true
        else
            return false
        end
    end

    def order
        # raise
            # binding.pry
            category = Category.find(@params["category"].to_i)
            quantity = @params["quantity"].to_i
            # raise
            # binding.pry
            if @user.credits.find_by(category: category)
                credit = @user.credits.find_by(category_id: category.id)
                credit.quantity += quantity
                if !credit.save!
                    return false
                end
            else
                credit = Credit.create!(user: @user, category: category, quantity: quantity)
                if !credit.save!
                    return false
                end
            end
    end 
  end