
require 'async/mysql/connection'

RSpec.describe Async::MySQL::Connection do
	include_context Async::RSpec::Reactor
	
	let(:connection_string) {"host=localhost dbname=test"}
	let(:connection) {Async::MySQL::Connection.new(connection_string)}
	
	it "should execute query" do
		reactor.async do
			results = connection.async_exec("SELECT 42 AS LIFE")
		
			expect(results.each.to_a).to be == [{"life" => "42"}]
			
			connection.close
		end
	end
end
