class TopicsController < ApplicationController
  layout "forumLayout"
  #before_filter :authenticate, :only=>[:new,:create,:destroy]
  # GET /topics
  # GET /topics.xml
  def index
    @forum=Forum.find(params[:forum_id])
    @topics = @forum.topics

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
    @forum=Forum.find(@topic.forum_id)
    @posts=@topic.posts
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
     @forum=Forum.find(params[:forum_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
    @forum=Forum.find(@topic.forum_id)
  end

  # POST /topics
  # POST /topics.xml
  def create
    
    @forum=Forum.find_by_id(params[:forum_id])
    respond_to do |format|
      if @forum.topics.create!(params[:topic])
        format.html { redirect_to(@forum, :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @forum, :status => :created, :location => @forum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    @forum=Forum.find(@topic.forum_id)
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(forum_topics_path(@forum), :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    @forum=Forum.find(@topic.forum_id)
    respond_to do |format|
      format.html { redirect_to(@forum.topics_url) }
      format.xml  { head :ok }
    end
  end
end
