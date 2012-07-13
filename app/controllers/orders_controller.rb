class OrdersController < ApplicationController
before_filter :assigns_gateway

  include ActiveMerchant::Billing
  include OrdersHelper

  def checkout
     setup_purchase_params = get_setup_purchase_params( @cart, request)
    setup_response = @gateway.setup_purchase(@cart.total, setup_purchase_params)
    redirect_to @gateway.redirect_url_for(setup_response.token)
  end

  private
    def assigns_gateway
      @gateway ||= PaypalExpressGateway.new(
        :login=>'4.m_1341781146_biz_api1.live.cn',
        :password=>'1341781169',
        :signature=>'AX5sfdhfH6Bew2E.0EAdRdIPJ8ncA39SXYFtBoDc-A0fXuMxRgkmmdA4'
      )
    end
end
