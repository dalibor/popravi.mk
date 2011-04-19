class Api::V2::ProblemsController < Api::V2::BaseController
  before_filter :require_moderator, :only => :update_status

  layout false

  def index
    if params[:type] == "nearest"
      problems = Problem.find_nearest(params, 20)
    elsif params[:type] == "my"
      problems = Problem.find_my(params, 20)
    else # params[:type] == "latest"
      problems = Problem.find_latest(20)
    end

    @problems = []
    problems.each do |problem|
      @problems << {
        :id => problem.id,
        :url => problem_url(problem),
        :description => problem.description,
        :longitude => problem.longitude,
        :latitude => problem.latitude,
        :category => problem.category_name,
        :municipality_id => problem.municipality_id,
        :municipality => problem.municipality_name,
        :status => problem.status,
        :photo_small => problem.photo.url(:s).gsub(" ", "%20"),
        :photo_medium => problem.photo.url(:m).gsub(" ", "%20"),
        :created_at => problem.created_at.to_s(:rfc822)
      }
    end

    render_json(@problems)
  end

  def create
    @problem         = Problem.new(params[:problem])
    @problem.user    = user_from_session
    @problem.api_key = @api_key

    if @problem.save
      render_json({ :status => "ok", :id => @problem.id })
    else
      actions = {}
      actions[:category] = "sync" if @problem.errors[:category_id].present?
      actions[:municipality] = "sync" if @problem.errors[:municipality_id].present?

      render_json({ :status => "error", 
                                        :message => @problem.errors.full_messages.join(", "), 
                                        :actions => actions })
    end
  end

  def update
    #File.open('t.jpg', "wb") { |f| f.write(params['media'].read) }
    @problem = Problem.find(params[:id])

    token = (params[:token].read rescue params[:token])

    # if photo is submitted from the same device
    if @problem.token.to_s == token.to_s
      @problem.photo = params[:photo]

      if @problem.save
        render_json({ :status => "ok" })
      else
        render_json({ :status => "error", :type => "photo" })
      end
    else
      render_json({ :status => "error", :type => "token" })
    end
  end

  def update_status
    problem = Problem.find(:first, :conditions => { :id => params[:id],
                                      :municipality_id => @editor.municipality_id })

    if problem.present? && params[:status].present?
      problem.status = params[:status]
      problem.last_editor = @editor

      if problem.save
        render_json({ :status => "ok" })
      else
        render_json({ :status => "error" })
      end
    else
      render_json({ :status => "error" })
    end
  end
end
