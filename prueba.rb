#recibe una api y devuelve un hash
require 'uri'
require 'net/http'
require 'json'
require 'openssl'

def request(url_partial, api_key)
    url_requested = url_partial + api_key
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    JSON.parse(response.body)
    #response.body
end

hash = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=','VXrdLWhDele8tfc4SJfuH0c6WFlFzS3KIoOozJgo') 

def inicio_web()
    '<html>
        <head>
        </head>
        <body>
            <ul>
            '
end

def final_web()
        '</ul>
        </body>
    </html>'
end

=begin
def link_photos(hash)
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
    return arr
end
=end

def photos_count(hash)
    f = 0
    r = 0
    m = 0
    c = 0
    n = 0
    m1 = 0
    n1 = 0
    has = {}
    hash.each do |key, value|
        (value).each do |k|
            k.each do |ke,va|
                if ke == 'camera'
                    va.each do |clave,valor|
                        if clave == 'name' 
                            has[valor] = va[valor]
                            case valor
                                when 'FHAZ'
                                    f += 1
                                    has[valor] = f
                                when 'RHAZ'
                                    r += 1
                                    has[valor] = r
                                when 'MAST'
                                    m += 1
                                    has[valor] = m
                                when 'CHEMCAM'
                                    c += 1
                                    has[valor] = c
                                when 'MAHLI' 
                                    m1 += 1
                                    has[valor] = m1
                                when 'NAVCAM'
                                    n1 += 1
                                    has[valor] = n1
                            end
                        end
                    end
                end
            end
        end        
    end
    return has 
end

#puts "#{photos_count(hash)}"
#puts "#{link_photos(hash)}"




def buid_web_page(hash)
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
    n = arr.length-1
    lista = ""
    for i in (0..n)
        lista = lista + "\t<li><img src='#{arr[i]}'></li> \n\t\t\t"
        
    end   
    
    index = inicio_web() + lista + final_web() 
    File.write('./index.html', index)
end


buid_web_page(hash)

