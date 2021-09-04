class ImportFileJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    p args
  end
end
