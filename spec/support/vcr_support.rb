require "vcr"

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.stub_with :fakeweb
  c.default_cassette_options = {:record => :new_episodes}
end