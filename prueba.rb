#recibe una api y devuelve un hash
require 'uri'
require 'net/http'
require 'json'

def request(url_partial, api_key)
    url_requested = url_partial + api_key
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    JSON.parse(response.body)
    #response.body
end

hash = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=', 'DEMO_KEY') 
arr = []
hash.each do |key, value|
    (value).each do |k|
        k.each do |ke,va|
            if ke == 'img_src'
                arr.push(va)
            end
        end
    end           
end

print "#{arr}"