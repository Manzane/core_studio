module ApplicationHelper
    def create_cart_and_assign_to_user
        if current_user != nil && current_user.cart == nil
            cart = Cart.create(user: current_user)
        end
    end
    def user_avatar(user, size=40)
        # if user.avatar.attached?
        #   # user.avatar.variant(resize: "#{size}x#{size}!")
        #   user.avatar.key
        if user.image
          image_url(user.image)
        else
          image_url("avatar.jpg")
        end
      end
    
end
