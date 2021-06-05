module Docs
  module V1
    module Users
      extend Dox::DSL::Syntax

      document :api do
        resource 'Users' do
          endpoint '/users'
          group 'Users'
        end
      end

      document :show do
        action 'Show current user profile'
      end

      document :update do
        action 'Update current user profile'
      end

      document :sign_up do
        action 'User registration'
      end

      document :sign_in do
        action 'User login'
      end

      document :destroy do
        action 'Destroy current user'
      end
    end
  end
end
