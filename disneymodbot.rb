require 'redd'
require 'dotenv'
Dotenv.load

SUBREDDIT = 'disney'

def build_session
  Redd.it(
    user_agent: ENV['USER_AGENT'],
    client_id: ENV['CLIENT'],
    secret: ENV['SECRET'],
    username: ENV['USERNAME'],
    password: ENV['PASSWORD']
  )
end

def check_new_queue
  session = build_session
  begin
    last_updated = File.open('last_update.txt', &:readline).to_i

    new_posts = session.subreddit(SUBREDDIT).new.stream do |post|
      # puts "Last Updated: #{last_updated}"
      # puts "Post Time: #{post.created_at.to_i}"

      next if post.created_at.to_i <= last_updated
      File.open('last_update.txt', 'w') { |f| f.write(post.created_at.to_i) }

      puts "----Checking: #{post.id} -- #{post.title}"
      results = session.subreddit(SUBREDDIT).search(post.title).reject { |result| result.id == post.id }

      if results.any? { |result_post| result_post.title == post.title }
        post.report('Suspected Repost')
        puts results.collect{|x| "#{x.id} -- #{x.title}"}.join("\n")
        puts "Reporting....."
      end
      sleep 2
    end
  rescue => exception
    puts exception
    check_new_queue
  end
end

check_new_queue