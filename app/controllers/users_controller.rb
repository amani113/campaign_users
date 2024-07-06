class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {data: @user,message: "user created successfully"},status: :created
    else
      render json: {errors: @user.errors.full_messages},status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: {data: @users}
  end

  def filter
    campaign_filters = params[:campaign_names]&.split(',')
    if campaign_filters.present?
      @users = User.all.select do |user|
        user_campaign_names = (user.campaigns_list || []).map { |campaign| campaign['campaign_name'] }
        (campaign_filters & user_campaign_names).any?
      end
      render json: { data: @users }
    else
      render json: { errors: "No campaigns found" }, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, campaigns_list: [:campaign_name, :campaign_id])
  end

end
