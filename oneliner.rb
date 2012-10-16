require 'sinatra'
require 'rinku'
require 'public_suffix'


get '/' do
  @hostname = request.host
  @oneliner = oneliner(request.host)
  if !@oneliner
    @oneliner = Rinku.auto_link("We can't find a one-liner for this hostname. Have you set up correctly? See http://oneliner.io/about.")
  end
  erb :index
end

get '/about' do
  erb :about
end

get '/*' do
  redirect "/"
end


def oneliner(hostname)
  hostname = sanitize(hostname)
  domain = PublicSuffix.parse(hostname).domain if PublicSuffix.valid?(hostname)
  records = %x[dig +short #{hostname} TXT].split("\n")
  records += %x[dig +short #{domain} TXT].split("\n") if hostname.include? "www"
  records.each do |record|
    segments = record.delete('"').split(" ", 2)
    if segments[0] == "oneliner.io"
     return Rinku.auto_link(segments[1])
    end
  end
  return false
end

def sanitize(hostname)
  hostname.gsub(/[^a-zA-Z1-9.+-_]/, '')
end

