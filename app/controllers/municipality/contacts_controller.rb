class Municipality::ContactsController < Municipality::BaseController

  def edit
    @contact = @municipality.contact
  end

  def update
    @contact = @municipality.contact

    if @contact.update_attributes(params[:contact])
      flash[:notice] = 'Contact details were successfully saved.'
      redirect_to municipality_edit_contact_url(@municipality, @contact)
    else
      render :edit
    end
  end
end
