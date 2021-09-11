require 'roo'
require 'active_record'
require 'active_model'

class Office
  def initialize(attribute)
    file = attribute[:file]
    @content  = []
    @spreadsheet = Roo::Spreadsheet.open(file) if file.present?    
  end

  def count
    @spreadsheet.last_row
  end

  def header
    @spreadsheet.header_line > 0 ? @spreadsheet.row(1) : []
  end

  def rows
    (2..@spreadsheet.last_row).map{|row| @spreadsheet.row(row)}
  end

  def to_h(option = { symbolize_keys: false })
    header = option[:symbolize_keys] ? self.header.map(&:to_sym) : self.header     
    (2..@spreadsheet.last_row).map{|row| Hash[[header, @spreadsheet.row(row)].transpose]}
  end

  def each_row(callback = nil)
    return unless block_given?

    header = self.header.map(&:to_sym)

    (2..@spreadsheet.last_row).each do |row|
      data = Hash[[header, @spreadsheet.row(row)].transpose]
      yield callback.nil? ? nil : eval(callback + "(#{data})")
    end
  end
end