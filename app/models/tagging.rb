class Tagging < ApplicationRecord
  belongs_to :tutorial
  belongs_to :tag
end
