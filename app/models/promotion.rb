class Promotion < ApplicationRecord
  enum status: { waiting_for_approval: 0, approved: 1, issued: 2 }
end
