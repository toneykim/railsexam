class ProductsController < ApplicationController

def allproducts
@uid = session[:user_id]

@first_name = User.find(@uid).first_name

@forsale = Product.where(sold:nil).joins(:user).select("*","id","created_at")



end



def dashboard
@uid = session[:user_id]

@first_name = User.find(@uid).first_name
@notyetsold = User.find(@uid).products.where(sold:nil)

@sales = Product.where(user_id:@uid).joins(:product_owners).select("*")

@totalsales = Product.where(user_id:@uid).joins(:product_owners).sum(:amount)


@purchases = Buying.where(user_id:@uid).joins(:product).joins(:user).select("*")

@totalpurchases = Buying.where(user_id:@uid).joins(:product).joins(:user).sum(:amount)
end

def create
@uid = session[:user_id]

@a1 = Product.new(item_name:params[:item_name], amount:params[:amount].to_f,user_id:@uid)

	if @a1.save
		flash[:success] = ["Item has been created"]
		redirect_to :back

	else
		flash[:errors] = @a1.errors.full_messages
		redirect_to :back

	end


end


def destroy

@uid = session[:user_id]
@pid = params[:id]

@del = Product.find(@pid)

	if @del.destroy
		flash[:success]=["Product Removed"]
		redirect_to :back
	else 
		flash[:errors]=["Product not removed"]
		redirect_to :back
	end




end


def buy
@uid = session[:user_id]
@pid = params[:id]

#flash[:success]=["#{@pid}"]
Product.find(@pid).update(sold:true)

Buying.create(user_id:@uid, product_id:@pid)

redirect_to :back

end



end
