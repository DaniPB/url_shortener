class CleanLinksWorker
  include Sidekiq::Worker

  def perform(*args)
    date = Time.now - 6.months
    links = Link.where("created_at < ?", date)

    links.destroy_all
  end
end
