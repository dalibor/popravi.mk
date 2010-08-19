class Api::V1::ProblemsController < ApplicationController

  layout false

  def index
    if params[:type] == "nearest"
      #problems = Problem.find :all, :select => "problems.*, categories.name AS category_name, municipalities.name AS municipality_name, SQRT( POW( 69.1 * ( latitude - #{params[:latitude]}) , 2 ) + POW( 69.1 * ( #{params[:longitude]} - longitude ) * COS( latitude / 57.3 ) , 2 ) ) AS distance",
                              #:joins => "JOIN categories ON categories.id = problems.category_id JOIN municipalities ON municipalities.id = problems.municipality_id",
                              #:order => "distance ASC",
                              #:limit => 20
      problems = Problem.find :all, :select => ActiveRecord::Base.send(:sanitize_sql_array, ["problems.*, categories.name AS category_name, municipalities.name AS municipality_name, SQRT( POW( 69.1 * ( latitude - ? ) , 2 ) + POW( 69.1 * ( ? - longitude ) * COS( latitude / 57.3 ) , 2 ) ) AS distance", params[:latitude], params[:longitude]]),
                              :joins => "JOIN categories ON categories.id = problems.category_id JOIN municipalities ON municipalities.id = problems.municipality_id",
                              :order => "distance ASC",
                              :limit => 20
    elsif params[:type] == "my"
      problems = Problem.find :all, :select => "problems.*, categories.name AS category_name, municipalities.name AS municipality_name", 
                              :joins => "JOIN categories ON categories.id = problems.category_id JOIN municipalities ON municipalities.id = problems.municipality_id",
                              :conditions => ['device_id = ?', params[:device_id]],
                              :order => "problems.id DESC",
                              :limit => 20
    else # params[:type] == "latest"
      problems = Problem.find :all, :select => "problems.*, categories.name AS category_name, municipalities.name AS municipality_name", 
                              :joins => "JOIN categories ON categories.id = problems.category_id JOIN municipalities ON municipalities.id = problems.municipality_id",
                              :order => "problems.id DESC",
                              :limit => 20
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
        :municipality => problem.municipality_name,
        :photo_small => problem.photo.url(:s).gsub(" ", "%20"),
        :photo_medium => problem.photo.url(:m).gsub(" ", "%20"),
        :created_at => problem.created_at.to_s(:rfc822) #problem.created_at.strftime("%b %d, %Y %H:%M:%S")
      }
    end

    respond_to do |format|
      format.json { render :json => @problems.to_json }
    end
  end

  def create
    @problem = Problem.new(params[:problem])

    if @problem.save
      respond_to do |format|
        format.json { render :json => {:status => "ok", :id => @problem.id}.to_json }
      end
    else

      actions = {}

      if @problem.errors.on(:category)
        actions[:category] = "sync"
      end

      if @problem.errors.on(:municipality)
        actions[:municipality] = "sync"
      end

      respond_to do |format|
        format.json { render :json => {:status => "error", :message => @problem.errors.full_messages. join(", "), :actions => actions}.to_json }
      end
    end
  end

  def update
    #File.open('t.jpg', "wb") { |f| f.write(params['media'].read) }
    @problem = Problem.find(params[:id])

    device_id = params[:device_id].read

    # if photo is submitted from the same device
    if @problem.device_id == device_id
      @problem.photo = params[:photo]

      if @problem.save
        respond_to do |format|
          format.json { render :json => {:status => "ok"}.to_json }
        end
      else
        respond_to do |format|
          format.json { render :json => {:status => "error", :type => "photo"}.to_json }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => {:status => "error", :type => "device_id"}.to_json }
      end
    end
  end
end
