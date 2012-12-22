class User::RatesController < User::BaseController
  before_filter :load_problem

  def create
    @rate = @problem.rates.new(params[:rate])
    @rate.user = current_user

    if @rate.save
      redirect_to problem_path(@problem), :notice => t('rates.flash.create.success')
    else
      render_problem_show
    end
  end

  def update
    @rate = current_user.rates.where(['problem_id = ?', @problem.id]).first
    if @rate.update_attributes(params[:rate])
      redirect_to problem_path(@problem), :notice => t('rates.flash.update.success')
    else
      render_problem_show
    end
  end

  private
    def load_problem
      @problem = Problem.find(params[:problem_id])
    end
end
