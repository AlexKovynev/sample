require 'rufus-scheduler'

loader = InfoLoader.new('http://localhost:3000')
Rufus::Scheduler.singleton(max_work_threads: 1).every '5m' do
  puts Time.now.to_s + ' start load data'
  ActiveRecord::Base.transaction do
    loader.load_all
  end
  puts Time.now.to_s + ' end load data'
end

