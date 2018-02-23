class Asset < ApplicationRecord
  serialize :evaluation, JSON
  after_initialize :set_defaults

  def set_defaults
    self.evaluation ||= {}
  end
end
