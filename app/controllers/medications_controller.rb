class MedicationsController < ApplicationController

  #BEGIN GET ACTIONS

  get '/medications/new' do
    erb :'medications/create_medication'
  end

  get '/medications/:id/edit' do
    @med = Medication.find_by(id: params[:id])

    if @med.blank?
      flash[:message] = "Can't find that medication."
      redirect to '/error'
    end

    if session[:user_id] != @med.user_id
      flash[:message] = "Oops - that med doesn't belong to you!"
      redirect to '/error' #change this redirect later
    end

    erb :'medications/edit_medication'
  end

  get '/medications/:id' do
    @med = Medication.find_by(id: params[:id])

    if @med.blank?
      redirect to '/error'
    end

    @edit_link = '/medications/' + @med.id.to_s + '/edit'
    @delete_link = '/medications/' + @med.id.to_s + '/delete'

    erb :'medications/view_medication'
  end

  #BEGIN POST ACTIONS

  post '/medications/:id/delete' do
    # puts "--- Made it to get!! ---"
    @med = Medication.find_by(id: params[:id])

    if @med.blank?
      flash[:message] = "Can't find that medication."
      redirect to '/error'
    end

    if session[:user_id] != @med.user_id
      flash[:message] = "Oops - that med doesn't belong to you!"
      redirect to '/error' #change this redirect later
    end

    Medication.delete(@med.id)

    redirect to '/'
  end

  post "/medications/new" do
    if session[:user_id].blank? #no user should ever see this, but trap not logged in exceptions
      redirect to '/error'
    end

    @user = User.find_by(id: session[:user_id]) #get logged in user

    # @user_medication_names = [] #gather user medications into an array for easier validation
    # @user.medications.each do |med|
    #   @user_medication_names << med.name
    # end

    if medication_valid?(params) == false
      redirect to '/medications/new'
    end

    if @user.med_names.include?(params[:name].downcase) #check if med is a duplicate
      flash[:message] = 'You already have a medication by that name. Try editing or deleting the existing med first.'
      redirect to '/profile'
    end

    #medication required fields validation goes here

    @med = Medication.new(
      name: params[:name].downcase,
      nickname: params[:nickname].downcase,
      condition: params[:condition].downcase,
      doctor: params[:doctor].downcase,
      prescribed: params[:prescribed],
      dosage: params[:dosage],
      dosage_units: params[:dosage_units].downcase,
      frequency: params[:frequency].downcase,
      user_id: @user.id,
      added: Date.today.month.to_s + "/" + Date.today.day.to_s + "/" + Date.today.year.to_s
    )

    puts @med
    @med.save
    #redirect to '/medications/' + @med.id.to_s
    redirect to '/profile'

  end

  #BEGIN PATCH ACTIONS

  patch '/medications/:id/edit' do
    @med = Medication.find_by(id: params[:id])

    if @med.blank?
      flash[:message] = "Can't find that medication."
      redirect to '/error'
    end

    if session[:user_id] != @med.user_id
      flash[:message] = "Oops - that med doesn't belong to you!"
      redirect to '/error' #change this redirect later
    end

    if medication_valid?(params) == false
      redirect to '/medications/' + params[:id].to_s + '/edit'
    end

    @user = User.find_by(id: session[:user_id])
    # @user_medication_names = [] #gather user medications into an array for easier validation
    # @user.medications.each do |med|
    #   @user_medication_names << med.name
    # end


    if (params[:name].downcase != @med.name.downcase) && (@user.med_names.include?(params[:name].downcase)) #if they're changing to a new name and it already exists...
      flash[:message] = 'You already have a medication by that name. Try editing or deleting the existing med first.'
      redirect to '/profile'
    end

    @med.update(
      name: params[:name].downcase,
      nickname: params[:nickname].downcase,
      condition: params[:condition].downcase,
      doctor: params[:doctor].downcase,
      prescribed: params[:prescribed],
      dosage: params[:dosage],
      dosage_units: params[:dosage_units].downcase,
      frequency: params[:frequency].downcase
    )

    redirect to '/medications/' + @med.id.to_s

  end

  def medication_valid?(med_params)
    if med_params[:name].blank?
      flash[:message] = "Medication name cannot be blank."
      return false
    elsif med_params[:condition].blank?
      flash[:message] = "Condition cannot be blank."
      return false
    elsif med_params[:dosage].blank?
      flash[:message] = "Dosage cannot be blank."
      return false
    elsif med_params[:dosage_units].blank?
      flash[:message] = "Dosage units cannot be blank."
      return false
    else
      return true
    end
  end

end
