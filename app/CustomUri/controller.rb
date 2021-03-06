require 'rho/rhocontroller'

class CustomUriController < Rho::RhoController
  @layout = :simplelayout
 
  def index
    render :back => '/app'  
  end
  
  def send_sms
    WebView.navigate( 'sms:+1222333444' )
    
    render :action => :index
  end

  def open_external_url
    System.open_url('http://www.rhomobile.com')
    redirect :action => :index
  end
  
  def install_app
    if System::get_property('platform') == 'Blackberry'
        System.open_url('http://192.168.0.101:8080/ota-web/myapp.jad')    
    elsif System::get_property('platform') == 'ANDROID'        
        System.open_url('http://192.168.0.101:8080/myapp_signed.apk')
    elsif System::get_property('platform') == 'APPLE'
        System.open_url('itms-services://?action=download-manifest&url=http://rhohub-staging-ota.s3.amazonaws.com/4cd4461afab3be7862000004/rhodes-system-api-samples.plist')
    else
        System.open_url('http://192.168.0.101:8080/myapp.cab')
    end    
    
    redirect :action => :index
  end
 
end
