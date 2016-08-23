class OrdersController < ApplicationController

  protect_from_forgery except: :index

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @total = OrderDetail.joins(:product).where(:order_id => @order.id).sum('products.price')

    require 'libwebpay'
    require_relative '../views/certificates/certnormal.rb'

    urlReturn = "http://localhost:3000/orders/show/#{@order.id}?option=result"
    urlFinal = "http://localhost:3000/orders/show/#{@order.id}?option=end"
    amount = @total
    path = ''
    idSession = ''
    response_code = ''
    buyOrder = @order.id
    sessionId = @order.user_id


    if (params[:option])
      @action = params[:option]
    else
      @action = 'init'
    end

    #se rescatan variables de los certificados
    certificates = Certnormal.new
    webpay = Libwebpay.new(certificates)

    case @action
      when 'init'
        #Llamada a libreria Webpay initTransaction
        result_init = webpay.init_transaction(amount, buyOrder, sessionId, urlReturn, urlFinal)

        @token = result_init['token']
        @url = result_init['url']

        #Operaciones internas#
        if @order.operation_state_id.blank?
          @order.operation_state_id = 1 #Sin realizar
          @order.save
        end

      when 'result'

        if (params[:token_ws])
          @token = params[:token_ws]
        end

        #llamada a getResult
        @result_get = webpay.get_result(@token)
        accountingdate = @result_get['accountingdate']
        buyorder = @result_get['buyorder']
        cardnumber = @result_get['cardnumber']
        amount = @result_get['amount']
        commercecode = @result_get['commercecode']
        authorizationcode = @result_get['authorizationcode']
        paymenttypecode = @result_get['paymenttypecode']
        responsecode = @result_get['responsecode']
        transactiondate = @result_get['transactiondate']
        urlredirection = @result_get['urlredirection']
        vci = @result_get['vci']

        #Operaciones internas#
        if response_code.to_i.zero?
          @order.operation_state_id = 2 #Aceptada
          @order.save
          voucher = Voucher.new
          voucher.order_id = @order.id
          voucher.accounting_date = accountingdate
          voucher.buy_order = buyorder
          voucher.cardnumber = cardnumber
          voucher.amount = amount
          voucher.commerce_code = commercecode
          voucher.authorization_code = authorizationcode
          voucher.payment_type_code = paymenttypecode
          voucher.response_code = responsecode
          voucher.transaction_date = transactiondate
          voucher.url_direction = urlredirection
          voucher.vci = vci
          voucher.save
        end


      when 'end'

        if (params[:token_ws])
          @token = params[:token_ws]
        end

        #Operaciones internas#
        @order.operation_state_id = 3 #Rechazada o finalizada
        @order.save

      end

    render template: "orders/show/#{params[:page]}"
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.operation_state_id = 1 #Sin realizar

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:date_order, :user_id)
    end
end
