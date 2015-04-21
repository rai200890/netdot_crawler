class NetdotCrawler::XMLParser

  attr_accessor :source

  def initialize source
    @source = Nokogiri::XML(source)
  end

  def ap_devices
    @source.xpath('//Device[starts-with(@name, "ap")]')
  end

  def neighbor_interface
    @source.xpath("//Interface[@neighbor_xlink]").to_a.map do |interface|
      {
          name: interface["neighbor"],
          interface_id: interface_id(interface["neighbor_xlink"]),
          number: interface["number"]
      }
    end.first
  end

  def device_info id
    device = @source.xpath("//Device[@id=#{id}]").first
    {
        id: device["id"],
        name: device["name"],
        sysname: device["sysname"]
    }
  end

  def ip_address id
    @source.xpath("//Device[@id=#{id}]//snmp_target").to_a.map{ |device| device["address"] }.first
  end

  def device_id
    device_xlink = @source.xpath('//@device_xlink').first.value
    device_xlink.match(/Device\/(.*)/).to_a.last
  end

  def interface_id neighbor_xlink
    neighbor_xlink.match(/Interface\/(.*)/).to_a.last
  end

  def device_xlink
    @source.xpath('//@device_xlink').first.value
  end

  def interface_xlink
    @source.xpath('//@interface_xlink').first.value
  end

end
