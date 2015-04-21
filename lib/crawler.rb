class NetdotCrawler::Crawler

  def initialize username, password
    @client = NetdotCrawler::Client.new username, password
    @devices = @client.devices
    @devices_with_depth = @client.devices_with_depth
  end

  def device_info device_id
    NetdotCrawler::XMLParser.new(@devices).device_info(device_id)
  end

  def ip_address device_id
    NetdotCrawler::XMLParser.new(@devices_with_depth).ip_address(device_id)
  end

  def ap_devices
    NetdotCrawler::XMLParser.new(@devices).ap_devices
  end

  def neighbor_interface device_id
    NetdotCrawler::XMLParser.new(@client.interface_by_device_id(device_id)).neighbor_interface
  end

  def parent_device_id interface_id
    NetdotCrawler::XMLParser.new(@client.interface_by_id(interface_id)).device_id
  end
  def hosts
    NetdotCrawler::XMLParser.new(@client.hosts)
  end

  def aps_with_parent
    result = []
    ap_devices.to_a.each do |device|
      neighbor_interface = neighbor_interface(device[:id])

      if neighbor_interface
        parent_id = parent_device_id(neighbor_interface[:interface_id])

        child = device_info(device[:id]).merge(address: ip_address(device[:id]))
        parent = device_info(parent_id).merge(address: ip_address(parent_id))

        result << child.merge(parent: parent)
      end
    end
    timestamp = Time.now.strftime "%d%m%Y_%H%M%S"
    f = File.new("#{Dir.pwd}/aps_with_parent#{timestamp}.json", "w")
    f.puts(JSON.generate(result))
    f.close
  end

  def devices_with_ip
    ap_devices.to_a.each do |device|
      puts @client.hosts.xpath('//Ipblock[starts-with(@interface, "'+ device['name'] + '")]').first["address"]
    end
  end
end
