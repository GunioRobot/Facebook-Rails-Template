file 'config/s3.yml', <<-CODE
access_key_id: AKIAJOZZPATKEW7SIVOQ
secret_access_key: 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
CODE

rakefile 'heroku.rake', <<-CODE
namespace :heroku do
  desc "PostgreSQL database backups from Heroku to Amazon S3"
  task :backup => :environment do
    begin
      require 'aws/s3'
      puts "[#{Time.now}] heroku:backup started"
      name = "#{ENV['APP_NAME']}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.dump"
      db = ENV['DATABASE_URL'].match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)
      system "PGPASSWORD=#{db[2]} pg_dump -Fc --username=#{db[1]} --host=#{db[3]} #{db[4]} > tmp/#{name}"
      
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['s3_access_key_id'],
        :secret_access_key => ENV['s3_secret_access_key']
      )
      bucket = "#{ENV['APP_NAME']}-heroku-backups"
      AWS::S3::S3Object.store(name, open("tmp/#{name}"), bucket)

      system "rm tmp/#{name}"
      puts "[#{Time.now}] heroku:backup complete"
    end
  end
end

task :cron => :environment do
  Rake::Task['heroku:backup'].invoke
  User.send_upgrade_mail
end
CODE