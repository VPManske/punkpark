


require 'jimson'


desc 'get_punk_owners_from_jsonrpc'
task get_punk_owners_from_jsonrpc: :environment do
  client = Jimson::Client.new("localhost:4040") # the URL for the JSON-RPC 2.0 server to connect to
  result = client.add(1,2) # call the 'sum' method on the RPC server and save the result '3'
  p result

end


desc 'get_punk_owners_from_jsonrpc'
task regenerate_punks: :environment do


    p 'destroying punks '

    Punk.destroy_all

    client = Jimson::Client.new("localhost:4040") # the URL for the JSON-RPC 2.0 server to connect to


      p 'connected to client '

   (0..9999).each do |punk_id|

     result = client.getPunkOwner(punk_id) # call the 'sum' method on the RPC server and save the result '3'


     punk = Punk.new(id: punk_id, owner_eth_address: result)

     p result

     punk_image_id = punk_id.to_s

     while(punk_image_id.size < 3)
       punk_image_id = "0" + punk_image_id
     end

     punk_image_name = "punk" + punk_image_id

     image_path = "app/images/punks/"+punk_image_name+".png"

     punk.avatar = File.open(image_path)
     punk.save!
     p 'saved punk ' + punk_id.to_s
   end

end
