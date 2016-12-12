class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :update, :destroy]
  before_action :set_user, only: :create
  before_action :authenticate_user

  def index
    @transfers = Transfer.all

    render json: @transfers
  end

  def show
    render json: @transfer
  end

  def create
    @transfer = Transfer.new(transfer_params)
    if @transfer.save
      render json: @transfer, status: :created, location: @user
    else
      render json: @transfer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transfer.update(transfer_params)
      render json: @transfer
    else
      render json: @transfer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transfer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
      puts @user
    end

    # Only allow a trusted parameter "white list" through.
    def transfer_params
      params.require(:transfer).permit(:account_number_from, :account_number_to, :amount_pennies, :country_code_from, :country_code_to)
      .merge(user_id: params.require(:user_id))
    end
end
