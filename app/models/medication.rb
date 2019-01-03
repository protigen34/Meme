class Medication < ApplicationRecord
  has_many :times, :class_name => 'MedicationTime'
  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :unit, :presence => true, :inclusion => { :in => [ 'mg', 'mL', 'tabs', 'caps' ] }
  validates :quantity, :presence => true, :numericality => { :greater_than => 0 }
end
