module Users
  class DestroyUser < ActiveInteraction::Base
    object :user

    def execute
      user.destroy
    end
  end
end
