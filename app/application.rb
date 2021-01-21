class Application
  @@items = []
  def call(env)
    response = Rack::Response.new
    request = Rack::Request.new(env)

    if request.path.match(/items/)
      item_name = request.path.split('/items/').last
      names = @@items.collect do |item|
        item.name
      end
      if names.include?(item_name)
        found_item = @@items.find do |item|
          item.name == item_name
        end
        response.write found_item.price
      else
        response.write 'Item not found'
        response.status = 400
      end
    else
      response.write 'Route not found'
      response.status = 404
    end
    response.finish
  end
end
