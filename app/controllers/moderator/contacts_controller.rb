class Moderator::ContactsController < Moderator::BaseController
  before_filter :load_contact

  def edit
    @contact = @municipality.contact
  end

  def update
    @contact.attributes = params[:contact]

    if @contact.save
      flash[:notice] = 'Contact details were successfully saved.'
      redirect_to edit_moderator_contact_url(@contact)
    else
      render :edit
    end
  end

  private
    def load_contact
      @municipality = current_user.municipality
      @contact = @municipality.contact || @municipality.build_contact
    end
end
