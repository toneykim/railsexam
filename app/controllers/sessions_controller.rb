class SessionsController < ApplicationController

skip_before_action :require_login, only: [:index, :register, :login]




def index 

end

def register
	@a1 = User.new(register_params) 
	if @a1.save
		session[:user_id] = @a1.id
		redirect_to "/shoes"


	else
		flash[:errors]= @a1.errors.full_messages
		redirect_to :back

	end



end


def login
	@a1 = User.find_by(email: params[:user][:email])
	if @a1
		if @a1.authenticate(params[:user][:password])
			session[:user_id]=@a1.id
			redirect_to "/shoes"


		else
			flash[:errors]=["Incorrect Login "]
			#flash[:errors]=@a1.errors.full_messages
			redirect_to :back
			
		end




	else
		flash[:errors]=["Incorrect Login "]
		#flash[:errors]=@a1.errors.full_messages
		redirect_to :back
	
	end





end



def logout
	reset_session
	redirect_to "/"

end

private
	def register_params
		params.require(:users).permit(:first_name,:last_name, :email, :password, :password_confirmation)
	end

	def login_params
		params.require(:users).permit(:email, :password)
	end


	def correct_user
		if params[:id].to_i != session[:user_id].to_i
			flash[:errors]=["nice try dude #{params[:id].to_i} #{session[:user_id].to_i}"]
			redirect_to "/"
		else
		
		end
	end






end
