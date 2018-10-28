require 'net/http'
require 'uri'
require 'json'

class TicketAddresses
  def self.create_ticket_address(event_id, ticket_batch_id)
    account_name = "event##{event_id}:batch##{ticket_batch_id}"
    client.getnewaddress(account_name)
  end

  def self.ticket_address_paid(address)
    amount = client.getreceivedbyaddress address, 0
    amount
  end

  def self.client
    @client ||= BitcoinRPC.new(ENV['BITCOIN_RPC_URI'] || 'http://foo:j1DuzF7QRUp-iSXjgewO9T_WT1Qgrtz_XWOHCMn_O-Y=@bitcoin-abc-server:18332')
  end
end

class BitcoinRPC
  def initialize(service_url)
    @uri = URI.parse(service_url)
  end

  def method_missing(name, *args)
    post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    resp = JSON.parse( http_post_request(post_body) )
    raise JSONRPCError, resp['error'] if resp['error']
    resp['result']
  end

  def http_post_request(post_body)
    http    = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    request.body = post_body
    http.request(request).body
  end

  class JSONRPCError < RuntimeError; end
end

if $0 == __FILE__
  h = BitcoinRPC.new(BITCOIN_RPC_URI || 'http://foo:j1DuzF7QRUp-iSXjgewO9T_WT1Qgrtz_XWOHCMn_O-Y=@bitcoin-abc-server:18332')
  p h.getbalance
  p h.getinfo
  p h.getnewaddress
  p h.dumpprivkey( h.getnewaddress )
  # also see: https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_Calls_list
end
