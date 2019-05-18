module Admin
  class DonationsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Donation.
    #     page(params[:page]).
    #     per(10)
    # end
    
    def create
      resource = Donation.create_fake_donation_given_by(resource_params[:fake_title])
      authorize_resource(resource)
      
      if resource.persisted?
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Donation.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
