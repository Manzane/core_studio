class CreditsUpdater
    def initialize(params, user, options={})
      @params = params
      @user = user
      if options.has_key?(:lesson)
        @lesson = options[:lesson]
      end
    end
    attr_accessor :credits

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
        category = Category.find(@lesson.category_id)
        credit = @user.credits.find_by(category_id: category.id)
        credit.quantity -= @params[:quantity].to_i
        # raise
        if credit.save!
            return true
        else
            return false
        end
    end

    def order
        # raise
        @params[:package_ids].each do |item |
            # raise
            package = Package.find(item)
            category = Category.find(package.category_id)
            quantity = package.quantity
            # raise
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
  end