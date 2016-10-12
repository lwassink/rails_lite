require 'json'

class Flash
  def initialize(req)
    @req = req
    rs = req.cookies['_rails_lite_app_flash']
    @returned_store = rs.nil? ? {} : JSON.parse(rs)
    @store_to_send = {}
    @now_store = {}
  end

  def [](key)
    total_store = @returned_store.merge(@store_to_send).merge(@now_store)
    total_store[key.to_s]
  end

  def []=(key, value)
    @store_to_send[key] = value
  end

  def store_flash(res)
    attributes = {path: '/', value: @store_to_send.to_json}
    res.set_cookie('_rails_lite_app_flash', attributes)
  end

  def now
    @now_store
  end
end
