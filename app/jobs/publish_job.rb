class PublishJob < ActiveJob::Base
  # app/jobs/publish_job.rb
  def perform
   Content.where(:published_date=>nil).limit(1).update_all(state:"published", published_date:Time.now)
  end
end
