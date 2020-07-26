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
        raise
        # // params -> cart -> cart.packages - package.category_id, cart.packages - package.quantity
        
    end 
  end