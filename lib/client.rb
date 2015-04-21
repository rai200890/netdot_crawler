class NetdotCrawler::Client
  include HTTParty

  attr_accessor :cookie
  attr_accessor :response

  def initialize(username, password)
    login username, password
  end

  def login username, password
    response = HTTParty.post('http://www.wifi.uff.br/netdot/NetdotLogin', {body: {
        destination: "/netdot/",
        credential_0: username,
        credential_1: password
    }
    })
    self.cookie = response.request.options[:headers]['Cookie']
  end

  def get_url url
    HTTParty.get(url, headers)
  end


  def devices
    response = get_url 'http://www.wifi.uff.br/netdot/rest/device'
    response.body
  end

  def hosts
    response = get_url 'http://www.wifi.uff.br/netdot/rest/host'
    response.body
  end

  def interfaces
    response = get_url 'http://www.wifi.uff.br/netdot/rest/interface'
    response.body
  end

  def devices_with_depth
    response = get_url "http://wifi.uff.br/netdot/rest/device?depth=1"
    response.body
  end

  def interface_by_id id
    response = get_url "http://wifi.uff.br/netdot/rest/interface/#{id}"
    response.body
  end

  def interface_by_device_id id
    response = get_url "http://wifi.uff.br/netdot/rest/interface?device=#{id}"
    response.body
  end

  private

  def headers
    {headers: {'Cookie' => cookie }}
  end

end
