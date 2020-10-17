require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CleanLinksWorker, type: :worker do

  let(:subject) { described_class }

  before do
    Sidekiq::Worker.clear_all
    Sidekiq::Testing.fake!
  end

  after do
    Sidekiq::Worker.clear_all
  end

  describe "#perform" do
    it "Should enqueue the worker" do
      expect { subject.perform_async }.to change(subject.jobs, :size).by(1)

      Sidekiq::Worker.drain_all
    end
  end
end
