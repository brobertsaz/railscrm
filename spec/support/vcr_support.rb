require "vcr"

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :fakeweb
  c.default_cassette_options = {:record => :new_episodes}
end