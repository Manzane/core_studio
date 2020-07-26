class CreditsUpdater
    def initialize(params, user, lesson)
      @params = params
      @user = user
      @lesson = lesson
    end
    attr_accessor :credits
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
    def check_credits
        category = Category.find(@lesson.category_id)
        credit = @user.credits.find_by(category_id: category.id)
        if credit.quantity >= @params[:quantity].to_i
            return true
        else
            return false
        end
    end
    
    def decrease
        category = Category.find(@lesson.category_id)
        credit = @user.credits.find_by(category_id: category.id)
        credit.quantity -= @params[:quantity].to_i
        if credit.save!
            return true
        else
            return false
        end
    end
  end