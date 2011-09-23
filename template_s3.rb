rakefile 'heroku.rake' do
  <<-TASK
  namespace :heroku do
    desc "PostgreSQL database backups from Heroku to Amazon S3"
    task :backup => :environment do
      begin
        require 'aws/s3'
        puts "[\#{Time.now}] heroku:backup started"
        name = "\#{ENV['APP_NAME']}-\#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.dump"
        db = ENV['DATABASE_URL'].match(/postgres:\\/\\/([^:]+):([^@]+)@([^\\/]+)\\/(.+)/)
        system "PGPASSWORD=\#{db[2]} pg_dump -Fc --username=\#{db[1]} --host=\#{db[3]} \#{db[4]} > tmp/\#{name}"
      
        AWS::S3::Base.establish_connection!(
          :access_key_id     => ENV['S3_ACCESS_KEY_ID'],
          :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
        )
        bucket = "\#{ENV['APP_NAME']}-heroku-backups"
        AWS::S3::S3Object.store(name, open("tmp/\#{name}"), bucket)

        system "rm tmp/\#{name}"
        puts "[\#{Time.now}] heroku:backup complete"
      end
    end
  end

  task :cron => :environment do
    Rake::Task['heroku:backup'].invoke
  end
  TASK
end